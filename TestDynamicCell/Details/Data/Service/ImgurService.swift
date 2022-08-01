//
//  ImgurService.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 31.07.2022..
//

import UIKit
import Moya
import RxSwift

protocol ImgurService {
    func uploadComic(image: UIImageView)
}

final class ImgurServiceImpl {
    
    private let provider : MoyaProvider<ImgurAPI>()
    
    init(provider: MoyaProvider<ImgurAPI>) {
        self.provider = provider  //swinject
    }
    
    func uploadComic(image: UIImageView) {
        
        provider.rx.request(.upload(image),
                            callbackQueue: DispatchQueue.main,
                            completion: { [weak self] result in
            switch result {
            case .success(let result):
                do {
                    let upload = try result.map(ImgurResponse<UploadResult>.self)
                    
                    self.uploadResult = upload.data
                    print(self.uploadResult)
                    
                } catch {
                    print(error)
                }
            case .failure:
               fatalError("image upload didnt work")
            }
        }
                            
                            
                            })
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .
        
    }
    
    private func mapRequestError<T: Decodable>(error: Error) -> Single<APIResult<T>> {
        print(error)
        return .just(.error(APIError.init(statusCode: 404, title: "Something went wrong", description: "Please try again")))
    }
    
}
