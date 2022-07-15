//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit

protocol HomeViewModel {
    var dataCount: Int {get}
    
    func loadData()
    func getCellData(index: Int) -> CustomCollectionViewCell.Data?
    func getInitialData() -> NSDiffableDataSourceSnapshot<Section, OrganizedData>
}

class HomeViewModelImpl: HomeViewModel {
  
    var dataCount: Int {frameworks.count}
    private let getFrameworksUseCase: GetFrameworksUseCase
    private var frameworks : [Framework] = []
    private let mapper: HomeViewModelMapper
    
    public init(getFrameworksUseCase: GetFrameworksUseCase,
         mapper: HomeViewModelMapper) {
        
        self.getFrameworksUseCase = getFrameworksUseCase
        self.mapper = mapper
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
        snapshot.appendSections([Section.main, Section.second])
        snapshot.appendItems(mapper.returnSectionItems(section: Section.main), toSection: Section.main)
        snapshot.appendItems(mapper.returnSectionItems(section: Section.second), toSection: Section.second)
        
        return snapshot //datasource.apply(snapshot, animatingDifferences: false)
    }
    
}








