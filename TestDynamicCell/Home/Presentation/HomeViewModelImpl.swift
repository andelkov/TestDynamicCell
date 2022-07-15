//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

protocol HomeViewModel {
    var dataCount: Int {get}
    
    func returnImageDescription(index: Int) -> String
    func returnImageAsset(index: Int) -> UIImage
    func returnImageName(index: Int) -> String
    func returnAssetUrl(index: Int) -> URL
    func getInitialData() -> NSDiffableDataSourceSnapshot<Section, OrganizedData>
}

class HomeViewModelImpl: HomeViewModel {
    
    typealias HomeViewData = NSDiffableDataSourceSnapshot<Section, OrganizedData>             // di ovo stavit i da ne bude errora
    
    var dataCount: Int {MockData.frameworks.count}
    private lazy var frameworks : [Framework] = FrameworkServiceImpl.shared.getFrameworks()  //jel dobro ovako spremiti u sve u jednu varijablu pa da onda FrameworkService mora samo jednom                                                                                           posao napraviti
    private let getFrameworksUseCase: GetFrameworksUseCase
    private let mapper: HomeViewModelMapper                                                  //INFO: ne raditi instanciranje propetije, nego preko contructora
    
    public init(getFrameworksUseCase: GetFrameworksUseCase,
         mapper: HomeViewModelMapper) {
        
        self.getFrameworksUseCase = getFrameworksUseCase
        self.mapper = mapper
    }
    
    func returnImageDescription(index: Int) -> String {
        
        if index < self.frameworks.count {
            
            let description = self.frameworks[index].description
            
            return description
            
        } else {
            
            return self.frameworks[0].description
            
        }
    }
    
    func returnImageAsset(index: Int) -> UIImage {
        
        if index < self.frameworks.count {
            
            let image = UIImage(named: self.frameworks[index].imageName)
            
            return image!
            
        } else {
            
            return UIImage(named: self.frameworks[index].imageName)!
            
        }
    }
    
    func returnImageName(index: Int) -> String {
        
        if index < self.frameworks.count {
            
            let imageName = self.frameworks[index].name
            
            return imageName
            
        }
        else {
            return self.frameworks[index].name
        }
    }
    
    func returnAssetUrl(index: Int) -> URL {
        
        let returnUrl: URL
        
        if index < frameworks.count {
            guard let url = URL(string: self.frameworks[index].urlString) else { return MockData.safeUrl! }  //jel ovdje kršim neko pravilo Designa time što pristup MockData.safeURL
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








