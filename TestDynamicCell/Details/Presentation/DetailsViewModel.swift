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
    
    private let imgurUseCase : ImgurUseCase
    private let snapper: DetailsViewSnapper
    
    init(imgurUseCase: ImgurUseCase, snapper: DetailsViewSnapper) {
        self.imgurUseCase = imgurUseCase
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
        
        
//        let uploadComic = input.upload
//            .asObservable()
//            .subscribe(onNext: { _ in
//                print("fsasf")
//            })
//            .dispose()
        
        
        return Output(frameworkRx: input.load, showView: showView) //, upload: uploadComic
    }
    
}
