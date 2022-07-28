//
//  GetComicsUseCase.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation
import RxSwift

protocol GetComicsUseCase {
    func execute() -> Single<APIResult<MarvelResponse<Comic>>>
}

final class GetComicsUseCaseImpl: GetComicsUseCase {
    
    private let repository : ComicsRepository
    
    init(repository: ComicsRepository) {
        self.repository = repository
    }
    
    func execute() -> Single<APIResult<MarvelResponse<Comic>>> {
        repository.getComics()
    }
    
}
