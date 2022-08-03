//
//  UploadJSONUseCase.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 03.08.2022..
//

import Foundation
import RxSwift

protocol UploadJSONUseCase {
    func upload(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>>
}

final class UploadJSONUseCaseImpl: UploadJSONUseCase {
    
    private let repository : JSONPlaceholderRepository
    
    init(repository: JSONPlaceholderRepository) {
        self.repository = repository
    }
    
    func upload(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>> {
        repository.uploadJSON(data: data)
    }
    
}
