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
    
    private lazy var labelTextfield = UILabel()
    private lazy var button = UIButton()
    private lazy var usernameTextField = UITextField()
    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(usernameTextField)
        view.addSubview(labelTextfield)
        configureButton()
        configureUsernameTexfield()
        configureLabel()
        rxBinding()
    }
    
    private func configureButton() {
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
    
    private func configureLabel() {
        labelTextfield.textColor = .label
        labelTextfield.textAlignment = .center
        labelTextfield.font                        = UIFont.preferredFont(forTextStyle: .title2)
        labelTextfield.adjustsFontSizeToFitWidth   = true
        labelTextfield.text = ""
        
        labelTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            
        }
        
    }
    
    private func rxBinding() {
        button.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.pushHomeViewVC()
            })
            .disposed(by: self.disposeBag)

        usernameTextField.rx.text.orEmpty
            .filter { $0.count > 3 }
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) //.throttle
            .subscribe(onNext: { [unowned self] text in
                self.labelTextfield.text = text
            }).disposed(by: disposeBag)
    }
    
    private func pushHomeViewVC() {
        guard let viewController = Scene.home.viewController as? HomeViewController else {return}
        viewController.navBarTitle =  ((self.usernameTextField.text == "") ? "Lorem Ipsum" : self.usernameTextField.text)!
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


