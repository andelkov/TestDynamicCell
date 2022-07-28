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
    func getComics() -> Single<APIResult<[Comic]>>
}

final class ComicServiceImpl: ComicService {
    
    private let network : Network
    
    init(network: Network) {
        self.network = network  //swinject
    }
    
    func getComics() -> Single<APIResult<[Comic]>> {
        
        return network.request(target: .comics, responseType: [Comic].self)
        
    }

    
}


