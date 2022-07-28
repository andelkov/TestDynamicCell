//
//  ComicsRepositoryImpl.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation
import RxSwift

final class ComicsRepositoryImpl: ComicsRepository {
    
    private let service : ComicService
    
    init(service: ComicService) {
        self.service = service
    }
    
    func getComics() -> Single<APIResult<[Comic]>> {
        return service.getComics()
    }
    
}
