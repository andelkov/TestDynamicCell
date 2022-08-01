//
//  ImgurUseCaseImpl.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 01.08.2022..
//

import Foundation
import UIKit

protocol ImgurUseCase {
    func execute(image: UIImage)
}

final class ImgurUseCaseImpl: ImgurUseCase {
    
    private let repository : ImgurRepository
    
    init(repository: ImgurRepository) {
        self.repository = repository
    }
    
    func execute(image: UIImage) {
        repository.uploadComic(image: image)
    }
    
}
