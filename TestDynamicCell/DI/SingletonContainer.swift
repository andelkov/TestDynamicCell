//
//  SingletonContainer.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import Swinject

enum SingletonContainer {
    
    static let instance: Container = {
        let container = Container(defaultObjectScope: .container)
        
        container.register(FrameworkService.self) { _ in
            FrameworkServiceImpl()
        }
        
        container.register(FrameworkRepository.self) {
            FrameworkRepositoryImpl(service: $0.resolve(FrameworkService.self)!)
        }
        
        container.register(ComicService.self) { _ in
            ComicServiceImpl()
        }
        
        container.register(ComicsRepository.self) {
            ComicsRepositoryImpl(service: $0.resolve(ComicService.self)!)
        }
        
        return container
    }()
    
}
