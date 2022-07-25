//
//  SectionMapper.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import UIKit

protocol HomeViewModelMapper {
    func mapCellData(from frameworks: [Framework]) -> [CustomCollectionViewCell.Data]
}

final class HomeViewModelMapperImpl: HomeViewModelMapper {
    
    func mapCellData(from frameworks: [Framework]) -> [CustomCollectionViewCell.Data] {
        
        return frameworks.map { framework in
            CustomCollectionViewCell.Data(title: framework.name,
                                          description: framework.description,
                                          image:  UIImage(named: framework.imageName),
                                          url: URL(string: framework.urlString))
        }
        
    }

}


