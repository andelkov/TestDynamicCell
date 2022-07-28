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
    
    private let getComicsUseCase: GetComicsUseCase
    private let getFrameworksUseCase: GetFrameworksUseCase
    private let mapper: HomeViewModelMapper
    
    init(getComicsUseCase: GetComicsUseCase,
         getFrameworksUseCase: GetFrameworksUseCase,
         mapper: HomeViewModelMapper) {
        
        self.getComicsUseCase = getComicsUseCase
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
        let comics: Driver<[CustomCollectionViewCell.Data]>
        let navigate: Driver<Scene>
        let failure: Driver<APIError>
    }
    
    
    func transform(input: Input) -> Output {
        
        let comicsResult = input.load
            .asObservable()
            .debug()
            .flatMapLatest(getComicsUseCase.execute)
            .share()
        
        let comicsSuccess = comicsResult
            .compactMap(\.value)                    //
            .map(mapper.mapCellDataWithComics)
            .asDriver(onErrorJustReturn: [])
        
        let comicsFailure = comicsResult
            .compactMap(\.error)                 //
            .asDriver(onErrorJustReturn: APIError(statusCode: 0, title: "", description: nil))
        
        let navigate = input.itemSelected
            .map { item in
                Scene.details(data: item)
            }
        
        
        let loading = Driver.merge(
            comicsResult.map({ _ in
                false
            }).asDriver(onErrorJustReturn: false),
            input.load.map({ _ in
                true
            }))
            .distinctUntilChanged()
        
        return Output(loading: loading,
                      comics: comicsSuccess,
                      navigate: navigate,
                      failure: comicsFailure)
    }
    
}





