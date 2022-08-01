//
//  DetailsViewModel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewModel {
    private let snapper: DetailsViewSnapper
    
    init(snapper: DetailsViewSnapper) {
        self.snapper = snapper
    }
}

extension DetailsViewModel: ViewModelType {
    
    struct Input {
        let load: Driver<CustomCollectionViewCell.Data>
        let show: Observable<Bool>
    }
    
    struct Output {
        let frameworkRx: Driver<CustomCollectionViewCell.Data>
        let showView: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
    
        
        let showView = input.show
            .map{ bool in
                return bool
            }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
        
        return Output(frameworkRx: input.load, showView: showView)
    }
    
}
