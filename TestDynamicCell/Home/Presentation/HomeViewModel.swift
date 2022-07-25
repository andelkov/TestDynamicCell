//
//  HomeViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 12.07.2022..
//

import UIKit
import RxCocoa
import RxSwift


class HomeViewModel {
    
    private let getFrameworksUseCase: GetFrameworksUseCase
    private let mapper: HomeViewModelMapper
    
    init(getFrameworksUseCase: GetFrameworksUseCase,
         mapper: HomeViewModelMapper) {
        
        self.getFrameworksUseCase = getFrameworksUseCase
        self.mapper = mapper
    }
    
    
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let load: Driver<Void>
        let itemSelected: Driver<CustomCollectionViewCell.Data>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let frameworks: Driver<[CustomCollectionViewCell.Data]>
        let navigate: Driver<Scene>
    }
    
    
    func transform(input: Input) -> Output {
        
        
        let navigate = input.itemSelected
            .map { item in
                Scene.details(data: item)
            }
        
        let frameworks = input.load
            .asObservable()
            .flatMapLatest { [unowned self] in
                self.getFrameworksUseCase.execute()
            }
            .map { [unowned self] frameworks in
                self.mapper.mapCellData(from: frameworks)
            }
            .asDriver(onErrorJustReturn: [])
        
        
        let loading = Driver.merge(
            frameworks.map({ _ in
                false
            }),
            input.load.map({ _ in
                true
            }))
            .distinctUntilChanged()
        
        return Output(loading: loading,
                      frameworks: frameworks,
                      navigate: navigate)
    }
    
}





