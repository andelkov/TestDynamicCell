//
//  LoginViewController.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit
import SnapKit
import Swinject
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let button = UIButton()
    let usernameTextField = UITextField()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(usernameTextField)
        configureButton()
        configureUsernameTexfield()
        rxBinding()
    }
    
    private func configureButton() {
        //button.addTarget(self, action: #selector(pushHomeViewVC), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        
        button.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(50)
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
        usernameTextField.placeholder                 = "Enter a name here"
        usernameTextField.clearButtonMode             = .whileEditing
        
        usernameTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
    
    private func rxBinding() {
        button.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.pushHomeViewVC()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func pushHomeViewVC() {
        guard let viewController = Scene.home.viewController as? HomeViewController else {return}
        viewController.navBarTitle =  ((self.usernameTextField.text == "") ? "Lorem Ipsum" : self.usernameTextField.text)!
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


