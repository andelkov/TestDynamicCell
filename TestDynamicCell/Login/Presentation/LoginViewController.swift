//
//  LoginViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit
import SnapKit
import Swinject

class LoginViewController: UIViewController {
    
    let button = UIButton()
    let usernameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(usernameTextField)
        configureButton()
        configureUsernameTexfield()
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(pushHomeViewVC), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        
        button.snp.makeConstraints { make in
            make.bottom.right.equalTo(view).offset(-50)
            make.left.equalTo(view.snp.left).offset(50)
            make.height.equalTo(50)
        }
    }
    
    private func configureUsernameTexfield() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        usernameTextField.layer.cornerRadius          = 10
        usernameTextField.layer.borderWidth           = 2
        usernameTextField.layer.borderColor           = UIColor.systemGray4.cgColor
        
        usernameTextField.textColor                   = .label
        usernameTextField.tintColor                   = .label
        usernameTextField.textAlignment               = .center
        usernameTextField.font                        = UIFont.preferredFont(forTextStyle: .title2)
        usernameTextField.adjustsFontSizeToFitWidth   = true
        usernameTextField.minimumFontSize             = 12
        
        usernameTextField.backgroundColor             = .tertiarySystemBackground
        usernameTextField.autocorrectionType          = .no
        usernameTextField.returnKeyType               = .go
        usernameTextField.placeholder                 = "Don't click here"
        usernameTextField.clearButtonMode             = .whileEditing
        
        usernameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(30)
            make.left.equalTo(view.snp.left).offset(50)
            make.right.equalTo(view.snp.right).offset(-50)
            make.height.equalTo(50)
        }
    }
    
    @objc func pushHomeViewVC() {
        
//        let frameworkRepository: FrameworkRepository = FrameworkRepositoryImpl.shared
//        let getFrameworksUseCase: GetFrameworksUseCase = GetFrameworksUseCaseImpl(repository: frameworkRepository)
//        let frameworkMapper: HomeViewModelMapper = HomeViewModelMapperImpl()
//        let homeViewModel = HomeViewModelImpl(getFrameworksUseCase: getFrameworksUseCase, mapper: frameworkMapper)
        
        let homeViewModel = InstanceContainer.instance.resolve(HomeViewModel.self)!
        homeViewModel.navigationBarTitle = ((self.usernameTextField.text == "") ? "Lorem Ipsum" : self.usernameTextField.text)!
        
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
}


