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

//tu ide Protocol?

class DetailsViewController: MVVMViewController<DetailsViewModel> {
    
    
    
    //MARK: parameter
    var framework: CustomCollectionViewCell.Data!
    private let disposeBag = DisposeBag()//ovo smije biti tu po MVVM?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .natural
        label.textColor = .label
        return label
    }()
    
 
    override func bindInput() -> DetailsViewModel.Input {
        return DetailsViewModel.Input(load: Driver.just(framework) )
    }
    
    override func bindOutput(output: DetailsViewModel.Output) {
        
        output.frameworkRx
            .drive(onNext: {[unowned self] frameworkRx in
                
                self.imageView.image = frameworkRx.image
                self.name.text = frameworkRx.title
                self.descriptionLabel.text = frameworkRx.description
            })
            .disposed(by: disposeBag)
        
    }
    
    override func setupView() {
        self.view.backgroundColor = .systemBackground
        setupLayout()
    }
   
    
    private func setupLayout() {
        view.addSubview(imageView)
        view.addSubview(name)
        view.addSubview(descriptionLabel)
        
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.top.equalTo(view.safeAreaInsets).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view)
        }
    }
    
}
