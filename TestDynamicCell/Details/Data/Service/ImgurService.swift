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
    func uploadComic(image: UIImage)
}

final class ImgurServiceImpl: ImgurService {
    
    private let provider = MoyaProvider<ImgurAPI>()
    
    func uploadComic(image: UIImage) {
        
        self.provider.rx.request(.upload(image))
            .filterSuccessfulStatusCodes()
            .subscribe { event in
                
                switch event {
                case .success(let result):
                    do {
                        let upload = try result.map(ImgurResponse<UploadResult>.self)
                        print(upload.data)
                        
                    } catch {
                        print(error)
                    }
                case .failure:
                    fatalError("image upload didnt work")
                }
                
            }
        
    }
    
    func mapRequestError<T: Decodable>(error: Error) -> Single<APIResult<T>> {
        print(error)
        return .just(.error(APIError.init(statusCode: 404, title: "Something went wrong", description: "Please try again")))
    }
}




