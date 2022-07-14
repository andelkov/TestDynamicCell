//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import Foundation
import UIKit

class HomeViewModel {
    
    func returnImageAsset(index: Int) -> UIImage {
        
        if index < MockData.frameworks.count {
            
            let image = UIImage(named: MockData.frameworks[index].imageName)
            
            return image!
            
        } else {
            
            return UIImage(named: MockData.frameworks[0].imageName)!
            
        }
    }
    
    func returnImageName(index: Int) -> String {
        
        if index < MockData.frameworks.count {
            
            let imageName = MockData.frameworks[index].name
            
            return imageName
            
        }
        else {
            return MockData.frameworks[0].name
        }
    }
    
    func returnAssetUrl(index: Int) -> URL {
        
        let returnUrl: URL
        
        if index < MockData.frameworks.count {
            guard let url = URL(string: MockData.frameworks[index].urlString) else { return MockData.safeUrl! }
            returnUrl = url
            
        } else { returnUrl = MockData.safeUrl!}
        
        return returnUrl
        
    }
    
    
    static func returnSectionItems (section: Section) -> [OrganizedData] {
        
        switch section {
        case .main:
            print(".main engaged")
            return (1..<10).map { index -> OrganizedData in
                return OrganizedData(title: MockData.frameworks[index].name ,
                                     subtitle: MockData.frameworks[index].description,
                                     image: UIImage(named: MockData.frameworks[index].imageName)!)
            }
        case .second:
            print(".second engaged")
            return (10...15).map { index -> OrganizedData in
                return OrganizedData(title: MockData.frameworks[index].name,
                                     subtitle: MockData.frameworks[index].description,
                                     image: UIImage(named: MockData.frameworks[index].imageName)!)
            }
        }
        
    }
    
    
}








