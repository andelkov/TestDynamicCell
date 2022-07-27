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
        .delay(.milliseconds(500), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
}

//MARK: RequestObservable class
public class RequestObservable {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    public init(config:URLSessionConfiguration) {
        urlSession = URLSession(configuration:
                                    URLSessionConfiguration.default)
    }
    //MARK: function for URLSession takes
    public func callAPI<ItemModel: Decodable>(request: URLRequest) -> Observable<ItemModel> {
        //MARK: creating our observable
        return Observable.create { observer in
            //MARK: create URLSession dataTask
            
            
            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    let statusCode = httpResponse.statusCode
                    
                    do {
                        let _data = data ?? Data()
                        if (200...399).contains(statusCode) {
                            let objs = try self.jsonDecoder.decode(ItemModel.self, from: _data)
                            //MARK: observer onNext event
                            observer.onNext(objs)
                        }
                        else {
                            observer.onError(error!)
                        }
                    } catch {
                        //MARK: observer onNext event
                        observer.onError(error)
                    }
                    
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
            }
            task.resume()
            
            
            //MARK: return our disposable
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
