//
//  SectionMapper.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import UIKit

protocol HomeViewModelMapper {
    func mapCellDataWithFrameworks(from frameworks: [Framework]) -> [CustomCollectionViewCell.Data]
    func mapCellDataWithComics(from comics: MarvelResponse<Comic>) -> [CustomCollectionViewCell.Data]
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
     
    func mapCellDataWithComics(from comics: MarvelResponse<Comic>) -> [CustomCollectionViewCell.Data] {
        
        let comicsWithDescription = comics.data.results.filter({$0.description != nil})
        return comicsWithDescription.map { comic in
            CustomCollectionViewCell.Data.init(title: comic.title,
                                               description: comic.description ?? "defaulty",
                                               image: UIImage(named: "arkit"),
                                               url: URL(string: "https://developer.apple.com"))
        }


    }

}


