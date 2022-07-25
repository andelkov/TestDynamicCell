//
//  Scene.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import Foundation
import UIKit

enum Scene {
    case login
    case home
    case details(data: CustomCollectionViewCell.Data)
}

extension Scene {
    
    var viewController: UIViewController {
        
        let container = ViewControllerContainer.instance
        
        switch self {
        case .login:
            return LoginViewController()
        case .home:
            return container.resolve(type: HomeViewController.self)
        case .details(let data):
            
            let detailsVC = container.resolve(type: DetailsViewController.self)
            detailsVC.framework = data
            
            return detailsVC
        }
        
    }
    
}
