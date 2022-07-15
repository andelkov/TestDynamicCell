//
//  GetUseCase.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation

protocol GetFrameworksUseCase {
    func execute() -> [Framework]
}

final class GetFrameworksUseCaseImpl: GetFrameworksUseCase {
    
    private let repository : FrameworkRepository
    
    init(repository: FrameworkRepository) {
        self.repository = repository
    }
    
    func execute() -> [Framework] {
        repository.getFrameworks()
    }
    
}
