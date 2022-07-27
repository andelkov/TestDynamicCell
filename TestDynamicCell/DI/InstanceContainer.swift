//
//  Swinject.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 20.07.2022..
//

import Swinject

enum InstanceContainer {
    
    static let instance: Container = {
        let container = Container(parent: SingletonContainer.instance, defaultObjectScope: .transient)
        
        container.register(GetFrameworksUseCase.self ) {                                           //šta je "factory:"    //jel ide GFUseCase ili GFUseCaseImpl
            GetFrameworksUseCaseImpl(repository: $0.resolve(FrameworkRepository.self)!)
            
        }
        
        container.register(HomeViewModelMapper.self) { _ in
            HomeViewModelMapperImpl()
        }
        
        container.register(HomeViewModel.self) { 
            HomeViewModel(getFrameworksUseCase: $0.resolve(GetFrameworksUseCase.self)!, mapper: $0.resolve(HomeViewModelMapper.self)!)
        }
        
        container.register(DetailsViewModel.self) {_ in              // kako kad prosljedujemo data
            DetailsViewModel()
        }
        
        container.register(GetComicsUseCase.self) {
            GetComicsUseCaseImpl(repository: $0.resolve(ComicsRepository.self)!)
        }
        
        return container
        
    }()
    
    
    
}

