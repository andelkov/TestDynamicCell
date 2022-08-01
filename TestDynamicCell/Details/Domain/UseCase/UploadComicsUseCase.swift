//
//  UploadComicsUseCase.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 01.08.2022..
//

import Foundation
import UIKit

protocol UploadComicsUseCase {
    func execute(image: UIImage)
}

final class UploadComicsUseCaseImpl: UploadComicsUseCase {
    
    private let repository : ImgurRepository
    
    init(repository: ImgurRepository) {
        self.repository = repository
    }
    
    func execute(image: UIImage) {
        repository.uploadComic(image: image)
    }
    
}
