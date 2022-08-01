//
//  UIViewController+Ext.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 13.07.2022..
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSafariVC (with url:URL ) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        present(safariVC, animated: true)
    }
}
