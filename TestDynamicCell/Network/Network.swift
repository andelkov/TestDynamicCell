//
//  Network.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 28.07.2022..
//

import Foundation
import RxSwift
import Moya

enum APIResult<T> {
    case success(T)
    case error(APIError)
    
    var value : T? {
        switch self {
        case .error: return nil
        case .success(let response): return response
        }
    }
    
    var error : APIError? {
        switch self {
        case .error(let error): return error
        case .success: return nil
        }
    }
}

struct APIError: Error {
    let statusCode: Int
    let title: String
    let description: String?
}

protocol Network {
    func request<T: Decodable>(target: MarvelAPI, responseType: T.Type) -> Single<APIResult<T>>
}

final class NetworkImpl: Network {
    
    static let publicKey = "ffc09e4c41b35eba39d92383c06b01dc"
    static let privateKey = "52f3765e4a96eadda42e77e402e82cba86d2f81d"
    
    private let provider = MoyaProvider<MarvelAPI>()
    
    
    func request<T: Decodable>(target: MarvelAPI, responseType: T.Type) -> Single<APIResult<T>> {
    
        provider.rx.request(target)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map{try $0.filterSuccessfulStatusCodes()}
            .map{try $0.map(T.self)}
            .map{APIResult<T>.success($0)}
            .catch{ self.mapRequestError(error: $0)}
    }
    
    private func mapRequestError<T: Decodable>(error: Error) -> Single<APIResult<T>> {
        print(error)
        return .just(.error(APIError.init(statusCode: 404, title: "Something went wrong", description: "Please try again")))
    }
}
