//
//  FrameworkRepositoryImpl.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation

final class FrameworkRepositoryImpl: FrameworkRepository {
    
    private let service: FrameworkService
    
    init(service: FrameworkService) {
        self.service = service
    }
    
    func getFrameworks() -> [Framework] {
        return service.getFrameworks()
    }

}

extension FrameworkRepositoryImpl {
    static let shared: FrameworkRepositoryImpl = FrameworkRepositoryImpl(service: FrameworkServiceImpl.shared)
}

