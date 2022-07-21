//
//  ViewControllerContainer.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import Swinject

enum ViewControllerContainer {
    
    static let instance: Container = {
        let container = Container(parent: InstanceContainer.instance, defaultObjectScope: .transient)
        
        quickRegister(container: container, HomeViewController.self) { _, _ in
            //do nothing
        }
        
        quickRegister(container: container, DetailsViewController.self) { _, _ in
            //do nothing
        }
        
        return container
        
    }()
    
    private static func quickRegister<T: MVVMViewController<M>, M: ViewModelType>(container: Container, _ type: T.Type, resolverCallback: @escaping (T, Resolver) -> Void) {
        
        container.register(type) {
            
            let instance = T.init(viewModel: $0.resolve())
            
            resolverCallback(instance, $0)
            
            return instance
        }
    }
    
}

