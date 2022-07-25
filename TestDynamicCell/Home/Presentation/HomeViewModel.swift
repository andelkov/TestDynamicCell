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
        //no inputs, dodati nešto kasnije, neki button npr
    }
    
    struct Output {
        let loading: Driver<Bool>
        let frameworks: Driver<[CustomCollectionViewCell.Data]>
    }

    
    func transform(input: Input) -> Output {
        let frameworks = getFrameworksUseCase.execute()
            .map { [unowned self] frameworks in
                self.mapper.mapCellData(from: frameworks)
            }
            .asDriver(onErrorJustReturn: [])
        let loading = frameworks
            .map { _ in
                false
            }
            .startWith(true)
        
        return Output(loading: loading, frameworks: frameworks)
    }
    
}





