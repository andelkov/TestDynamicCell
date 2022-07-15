//
//  SectionMapper.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import UIKit

protocol HomeViewModelMapper {
    func returnSectionItems (section: Section) -> [OrganizedData]
}

final class HomeViewModelMapperImpl: HomeViewModelMapper {
    
    func returnSectionItems (section: Section) -> [OrganizedData] {
        
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


