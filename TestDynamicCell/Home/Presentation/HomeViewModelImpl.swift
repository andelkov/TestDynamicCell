//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

protocol HomeViewModel {
    var dataCount: Int {get}
    
    func returnImageAsset(index: Int) -> UIImage
    func returnImageName(index: Int) -> String
    func returnAssetUrl(index: Int) -> URL
    func getInitialData() -> NSDiffableDataSourceSnapshot<Section, OrganizedData>
}

class HomeViewModelImpl: HomeViewModel {
    
    typealias HomeViewData = NSDiffableDataSourceSnapshot<Section, OrganizedData>
    
    var dataCount: Int {MockData.frameworks.count}
    
    private let getFrameworksUseCase: GetFrameworksUseCase
    private let mapper: HomeViewModelMapper                                        //ne raditi instanciranje propetije, nego preko contructora
    
    public init(getFrameworksUseCase: GetFrameworksUseCase,
         mapper: HomeViewModelMapper) {
        
        self.getFrameworksUseCase = getFrameworksUseCase
        self.mapper = mapper
    }
    
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
    
    func getInitialData() -> HomeViewData {
        
        var snapshot = HomeViewData() //maket u ViewModel
        snapshot.appendSections([Section.main, Section.second])
        snapshot.appendItems(mapper.returnSectionItems(section: Section.main), toSection: Section.main)
        snapshot.appendItems(mapper.returnSectionItems(section: Section.second), toSection: Section.second)
        
        return snapshot //datasource.apply(snapshot, animatingDifferences: false)
    }
    
}








