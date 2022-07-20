//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit
//
//protocol HomeViewModel {
//    func loadData()
//    func getCellData(index: Int) -> CustomCollectionViewCell.Data?
//    func getInitialData() -> NSDiffableDataSourceSnapshot<Section, OrganizedData>
//}

class HomeViewModel {
    
    var navigationBarTitle: String
    private let getFrameworksUseCase: GetFrameworksUseCase
    var frameworks : [Framework] = []
    private let mapper: HomeViewModelMapper
    
    convenience init(getFrameworksUseCase: GetFrameworksUseCase,
                mapper: HomeViewModelMapper) {
        self.init(getFrameworksUseCase: getFrameworksUseCase,
                  mapper: mapper, title: "")
    }
    
    public init(getFrameworksUseCase: GetFrameworksUseCase,
                mapper: HomeViewModelMapper, title: String) {
        
        self.getFrameworksUseCase = getFrameworksUseCase
        self.mapper = mapper
        self.navigationBarTitle = title
    }
    
    func loadData() {
        self.frameworks = getFrameworksUseCase.execute()
    }
    
    func getCellData(index: Int) -> CustomCollectionViewCell.Data? {
        guard index < self.frameworks.count else {
            return nil
        }
        
        return mapper.mapCellData(from: self.frameworks[index])
    }
    
    func getInitialData() -> HomeViewData {
        
        var snapshot = HomeViewData() //maket u ViewModel
        snapshot.appendSections([Section.main])
        snapshot.appendItems(mapper.returnSectionItems(section: Section.main), toSection: Section.main)
        
        return snapshot                         //datasource.apply(snapshot, animatingDifferences: false)
    }
    
}








