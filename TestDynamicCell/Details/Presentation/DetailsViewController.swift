//
//  DetailsViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 20.07.2022..
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher
import Moya

//tu ide Protocol?

class DetailsViewController: MVVMViewController<DetailsViewModel> {
    
    //MARK: parameter
    var framework: CustomCollectionViewCell.Data!
    private let provider = MoyaProvider<Imgur>()
    private var uploadResult: UploadResult?
    private let disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .label
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    private lazy var toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Toggle visibility"
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        
        return label
        
    }()
    
    private lazy var toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.setOn(true, animated: false)
        
        return toggleSwitch
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()
    
    private lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload poster", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemRed
        
        return button
        
    }()
    
    
    override func bindInput() -> DetailsViewModel.Input {
        
        let toggleAction = toggleSwitch.rx.isOn.changed
            .distinctUntilChanged()
            .asObservable()
        
        return DetailsViewModel.Input(load: Driver.just(framework), show: toggleAction )
    }
    
    override func bindOutput(output: DetailsViewModel.Output) {
        
        output.frameworkRx
            .drive(onNext: {[unowned self] frameworkRx in
                
                self.imageView.kf.setImage(with: frameworkRx.url,placeholder: UIImage(named: "arkit"), options: [.transition(.fade(0.3))])
                self.name.text = frameworkRx.title
                self.descriptionLabel.text = frameworkRx.description
                
            })
            .disposed(by: disposeBag)
        
        output.showView.drive { [weak self] isShowing in
            
            isShowing ? self?.descriptionLabel.fadeIn() : self?.descriptionLabel.fadeOut()
            isShowing ? self?.uploadButton.fadeIn() : self?.uploadButton.fadeOut()
            
        }
        .disposed(by: disposeBag)
        
        uploadButton.rx.tap.asObservable()
            .bind { _ in
                
                self.provider.request(.upload(self.imageView.snapUIImageView()),
                                         callbackQueue: DispatchQueue.main,
                                         progress: nil,
                                         completion: { [weak self] result in
                    guard let self = self else { return }
                    
                    
                    // 6
                    switch result {
                    case .success(let result):
                        do {
                            let upload = try result.map(ImgurResponse<UploadResult>.self)
                            
                            self.uploadResult = upload.data
                            print(self.uploadResult)
                            
                        } catch {
                            print(error)
                        }
                    case .failure:
                       fatalError("image upload didnt work")
                    }
                
                })
            }
            .disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        self.view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(name)
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        view.addSubview(descriptionLabel)
        view.addSubview(uploadButton)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(100)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        toggleLabel.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        toggleSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(toggleLabel)
            make.right.equalToSuperview().offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(toggleSwitch.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(uploadButton.snp.top).offset(20)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(50)
            make.height.equalTo(50)
        }
    }
}
