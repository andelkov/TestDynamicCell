//
//  FrameworkService.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 15.07.2022..
//

import Foundation

protocol FrameworkService {
    func getFrameworks() -> [Framework]
}

final class FrameworkServiceImpl: FrameworkService {
    
    func getFrameworks() -> [Framework] {
        return MockData.frameworks
    }
    
}

// valja li ovaj pristup putem Singletona
extension FrameworkServiceImpl {
    static let shared: FrameworkService = FrameworkServiceImpl()
}
