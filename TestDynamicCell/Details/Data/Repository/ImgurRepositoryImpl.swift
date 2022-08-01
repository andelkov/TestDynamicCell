//
//  File.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 01.08.2022..
//

import UIKit

final class ImgurRepositoryImpl: ImgurRepository {
    
    private let service : ImgurService
    
    init(service: ImgurService) {
        self.service = service
    }
    
    func uploadComic(image: UIImage) {
        return service.uploadComic(image: image)
    }
    
}
