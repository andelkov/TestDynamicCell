//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import Foundation
import UIKit

class HomeViewModel {

    func returnImageAsset(imageIndex: Int) -> UIImage {
        
        if imageIndex <= 15 {
        
            let image = UIImage(named: MockData.frameworks[imageIndex].imageName)
        
            return image!
            
        } else {
            
            return UIImage(named: MockData.frameworks[0].imageName)!
            
        }
    }
    
    func returnImageName(imageIndex: Int) -> String {
        
        if imageIndex <= 15 {
        
            let imageName = MockData.frameworks[imageIndex].name
        
            return imageName
            
        } else {
            
            return MockData.frameworks[0].name
            
        }
    }
    
    
    static func returnSectionItems (section: Section) -> [OrganizedData] {
        
        switch section {
        case .main:
            return (1...10).map { index -> OrganizedData in
                return OrganizedData(title: MockData.frameworks[index].name ,
                            subtitle: MockData.frameworks[index].description,
                                image: UIImage(named: MockData.frameworks[index].imageName)!)
            }
        case .second:
            return (10...14).map { index -> OrganizedData in
                return OrganizedData(title: MockData.frameworks[index].name,
                            subtitle: MockData.frameworks[index].description,
                                     image: UIImage(named: MockData.frameworks[index].imageName)!)
            }
        }
        
    }
        
            
        
    }
    

