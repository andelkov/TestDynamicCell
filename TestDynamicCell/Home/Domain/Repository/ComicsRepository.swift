//
//  ComicsRepository.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation
import RxSwift

protocol ComicsRepository {
    func getComics() -> Single<[Comic]>
}
