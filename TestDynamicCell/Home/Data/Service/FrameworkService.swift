//
//  FrameworkService.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 15.07.2022..
//

import Foundation
import RxSwift

protocol FrameworkService {
    func getFrameworks() -> Single<[Framework]>
}

final class FrameworkServiceImpl: FrameworkService {
    
    func getFrameworks() -> Single<[Framework]> {
        return Single<[Framework]>.create { observer in
            observer(.success(MockData.frameworks))
            return Disposables.create()
        }
        .delay(.milliseconds(1000), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
}
