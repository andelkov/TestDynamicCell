//
//  UIImage+Ext.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 31.07.2022..
//

import UIKit


extension UIImageView {
    
    func snapUIImageView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Failed snapping card") }
        UIGraphicsEndImageContext()
        
        return image
    }
    
}


