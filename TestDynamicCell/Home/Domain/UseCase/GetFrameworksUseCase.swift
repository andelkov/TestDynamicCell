//
//  GetUseCase.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation
import RxSwift

protocol GetFrameworksUseCase {
    func execute() -> Single<[Framework]>
}

final class GetFrameworksUseCaseImpl: GetFrameworksUseCase {
    
    private let repository : FrameworkRepository
    
    init(repository: FrameworkRepository) {
        self.repository = repository
    }
    
    func execute() -> Single<[Framework]> {
        repository.getFrameworks()
    }
    
}
