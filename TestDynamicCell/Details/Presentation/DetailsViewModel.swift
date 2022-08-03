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
    
    private let uploadJSONUseCase: UploadJSONUseCase
    private let snapper: DetailsViewSnapper
    
    init(uploadJSONUseCase: UploadJSONUseCase, snapper: DetailsViewSnapper) {
        self.uploadJSONUseCase = uploadJSONUseCase
        self.snapper = snapper
    }
}

extension DetailsViewModel: ViewModelType {
    
    struct Input {
        let text: Driver<String?>
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
        
        var JSONForUpload = JSONPlaceholder(userId: 1, id: 101, title: "Default", body: "Default")
        
        input.text.drive(onNext: { userEmail in
            JSONForUpload = JSONPlaceholder(userId: 1, id: 101, title: "Default", body: userEmail ?? "no description")
        })
        
        let showView = input.show
            .map{ bool in
                return bool
            }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
        
        
        let uploadResult = input.upload
            .asObservable()
            .flatMapLatest({ _ in
                self.uploadJSONUseCase.upload(data: JSONForUpload)
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
