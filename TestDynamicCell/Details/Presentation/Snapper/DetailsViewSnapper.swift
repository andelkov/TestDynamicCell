//
//  File.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 01.08.2022..
//

import Foundation
import UIKit

protocol DetailsViewSnapper {
    func snapUIImageView(image: UIImageView) -> UIImage
}

final class DetailsViewSnapperImpl {
    
    func snapUIImageView(image: UIImageView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.bounds.size, true, UIScreen.main.scale)
        image.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Failed snapping card") }
        UIGraphicsEndImageContext()
        
        return image
    }
}
