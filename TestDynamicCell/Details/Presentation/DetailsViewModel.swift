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
  
}

extension DetailsViewModel: ViewModelType {
    
    struct Input {
        let load: Driver<CustomCollectionViewCell.Data>
    }
    
    struct Output {
        let frameworkRx: Driver<CustomCollectionViewCell.Data>
    }
    
    func transform(input: Input) -> Output {
    
        
        return Output(frameworkRx: input.load)
    }
    
}
