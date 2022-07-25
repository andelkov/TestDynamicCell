//
//  FrameworkRepositoryImpl.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation
import RxSwift

final class FrameworkRepositoryImpl: FrameworkRepository {
    
    private let service: FrameworkService
    
    init(service: FrameworkService) {
        self.service = service
    }
    
    func getFrameworks() -> Single<[Framework]> {
        return service.getFrameworks()
    }

}
