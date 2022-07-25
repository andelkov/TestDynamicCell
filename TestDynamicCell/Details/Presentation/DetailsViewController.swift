//
//  DetailsViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 20.07.2022..
//

import UIKit
import SnapKit  

//tu ide Protocol?

class DetailsViewController: MVVMViewController<DetailsViewModel> {
    
    //MARK: properties
    var framework: CustomCollectionViewCell.Data!                                                           //ovo smije biti tu po MVVM?
    
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
        return DetailsViewModel.Input()
    }
    
    override func bindOutput(output: DetailsViewModel.Output) {
        //self.framework = output.frameworks
        
    }
    
    override func setupView() {
        
        self.view.backgroundColor = .systemBackground
        print(framework)
        self.imageView.image = framework.image
        self.name.text = framework.title
        self.descriptionLabel.text = framework.description
        
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