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
        let upload: Driver<Void>
        let image: UIImageView
    }
    
    struct Output {
        let frameworkRx: Driver<CustomCollectionViewCell.Data>
        let showView: Driver<Bool>
        let upload: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
    
        let showView = input.show
            .map{ bool in
                return bool
            }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
        
        let uploadComic = input.upload
            .asDriver()
        
        
        
        return Output(frameworkRx: input.load, showView: showView, upload: uploadComic)
    }
    
}
