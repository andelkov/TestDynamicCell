//
//  LoginViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit

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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
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
        usernameTextField.placeholder                 = "Enter a username"
        usernameTextField.clearButtonMode             = .whileEditing
        
        NSLayoutConstraint.activate([
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushFollowerListVC() {
        
        //ovo je dio koji se treba pojednostaviti pomoću Swinject?
        let frameworkRepository: FrameworkRepository = FrameworkRepositoryImpl.shared
        let getFrameworksUseCase: GetFrameworksUseCase = GetFrameworksUseCaseImpl(repository: frameworkRepository)
        let frameworkMapper: HomeViewModelMapper = HomeViewModelMapperImpl()
        
        
        let homeViewModel = HomeViewModelImpl(getFrameworksUseCase: getFrameworksUseCase, mapper: frameworkMapper)
        let homeViewController = HomeViewController(homeViewModel: homeViewModel)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
}


