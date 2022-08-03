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
    
    let network = NetworkImpl()
    
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
    }
    
    struct Output {
        let frameworkRx: Driver<CustomCollectionViewCell.Data>
        let showView: Driver<Bool>
        
        let uploadSuccess: Driver<[JSONPlaceholder]>
        let failure: Driver<NetworkErrorConditions>
    }
    
    func transform(input: Input) -> Output {
        
        let showView = input.show
            .map{ bool in
                return bool
            }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
        
        
        let uploadResult = input.upload
            .asObservable()
            .flatMapLatest({ _ in
                self.network.upload(target: .upload, responseType: [JSONPlaceholder].self)
            })
            .share()
        
        let uploadSuccess = uploadResult
            .compactMap(\.value)
            .asDriver(onErrorJustReturn: [])
        
        let uploadFailure = uploadResult
            .compactMap{ result in
                return result.error
            }
            .asDriver(onErrorJustReturn: NetworkErrorConditions(badUrl: "Bad URL at request", dataCannotHandled: "Data cannot be handled properly."))
        
        return Output(frameworkRx: input.load,
                      showView: showView,
                      uploadSuccess: uploadSuccess,
                      failure: uploadFailure)
    }
    
}
