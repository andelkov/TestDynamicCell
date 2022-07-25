//
//  DataRepository.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation
import RxSwift

protocol FrameworkRepository {
    func getFrameworks() -> Single<[Framework]>
}

