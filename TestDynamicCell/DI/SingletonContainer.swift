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
        
        return container
    }()
    
}
