//
//  SectionMapper.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import UIKit

protocol HomeViewModelMapper {
    func mapCellDataWithFrameworks(from frameworks: [Framework]) -> [CustomCollectionViewCell.Data]
    func mapCellDataWithComics(from comics: [Comic]) -> [CustomCollectionViewCell.Data]
}

final class HomeViewModelMapperImpl: HomeViewModelMapper {
    
    func mapCellDataWithFrameworks(from frameworks: [Framework]) -> [CustomCollectionViewCell.Data] {
        
        return frameworks.map { framework in
            CustomCollectionViewCell.Data(title: framework.name,
                                          description: framework.description,
                                          image:  UIImage(named: framework.imageName),
                                          url: URL(string: framework.urlString))
        }
    }
     
    func mapCellDataWithComics(from comics: [Comic]) -> [CustomCollectionViewCell.Data] {
        return comics.map { comics in
            CustomCollectionViewCell.Data(title: comics.title,
                                          description: comics.description ?? "",
                                          image: UIImage(named: "arkit"),
                                          url: comics.thumbnail.url)
            
        }
    }

}


