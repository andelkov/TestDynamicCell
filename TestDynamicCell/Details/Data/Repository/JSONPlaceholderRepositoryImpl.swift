//
//  JSONPlaceholderRepositoryImpl.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 03.08.2022..
//

import Foundation
import RxSwift

final class JSONPlaceholderRepositoryImpl: JSONPlaceholderRepository {
   
    private let service: JSONPlaceholderService
    
    init(service: JSONPlaceholderService) {
        self.service = service
    }
    
    func uploadJSON(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>> {
        return service.uploadJSON(data: data)
    }

}
