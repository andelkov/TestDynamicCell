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
    
    private let provider = MoyaProvider<MarvelAPI>()
    
    private let uploadProvider = MoyaProvider<JSONPlaceholderAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
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
    
    func upload<T: Decodable>(target: JSONPlaceholderAPI, responseType: T.Type) -> Single<JSONPlaceholderResult<T>> {
        
        uploadProvider.rx.request(target)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .map{try $0.map(T.self) as! JSONPlaceholderResult<T>}
        
    }
    
    private func uploadRequestError<T: Decodable>(error: Error) -> Single<JSONPlaceholderResult<T>> {
        print(error)
        return .just(.error(NetworkErrorConditions.init(badUrl: "bad url", dataCannotHandled: "Data cant be handel") ))
    }
    
}



//            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
//            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
//            .map{try $0.filterSuccessfulStatusCodes() }
//            .map{T.self}
//            .map{JSONPlaceholderResult<T>.success($0 as! T)}
//            .catch{ self.uploadRequestError(error: $0)}
