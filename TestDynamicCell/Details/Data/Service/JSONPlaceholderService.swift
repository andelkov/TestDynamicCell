//
//  JSONPlaceholderService.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 03.08.2022..
//

import Foundation
import RxSwift

protocol JSONPlaceholderService {
    func uploadJSON(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>>
}

final class JSONPlaceholderServiceImpl: JSONPlaceholderService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func uploadJSON(data: Codable) -> Single<JSONPlaceholderResult<[JSONPlaceholder]>> {
        
        return network.upload(target: .upload(data), responseType: [JSONPlaceholder].self)
        
    }
    
    
}
