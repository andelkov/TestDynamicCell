//
//  MarvelService.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import UIKit
import SnapKit
import Swinject
import RxSwift
import Moya
import RxCocoa

protocol ComicService {
    var provider : MoyaProvider<Marvel> { get }
    func getComics() -> Single<[Comic]>
}

final class ComicServiceImpl: ComicService {
    
    internal var provider = MoyaProvider<Marvel>()
    
    func getComics() -> Single<[Comic]> {
        
        return provider.rx
            .request(.comics)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Comic].self)
        
    }
    
}

