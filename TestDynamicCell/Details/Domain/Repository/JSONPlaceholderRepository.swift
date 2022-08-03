//
//  JSONPlaceholderRepository.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 03.08.2022..
//

import Foundation
import RxSwift

protocol JSONPlaceholderRepository {
    func uploadJSON(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>>
}
