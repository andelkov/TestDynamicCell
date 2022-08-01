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
        
        container.register(GetFrameworksUseCase.self ) {
            GetFrameworksUseCaseImpl(repository: $0.resolve())
            
        }
        
        container.register(HomeViewModelMapper.self) { _ in
            HomeViewModelMapperImpl()
        }
        
        container.register(HomeViewModel.self) { 
            HomeViewModel(getComicsUseCase: $0.resolve(),
                          getFrameworksUseCase: $0.resolve(),
                          mapper: $0.resolve())
        }
        
        container.register(GetComicsUseCase.self) {
            GetComicsUseCaseImpl(repository: $0.resolve())
        }
        
        container.register(UploadComicsUseCase.self) {
            UploadComicsUseCaseImpl(repository: $0.resolve())
        }
        
        container.register(DetailsViewSnapper.self) { _ in
            DetailsViewSnapperImpl()
        }
        
        container.register(DetailsViewModel.self) {
            DetailsViewModel(uploadComicsUseCase: $0.resolve(), snapper: $0.resolve())
        }
        
        return container
        
    }()
    
    
    
}

