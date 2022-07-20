//
//  Swinject.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 20.07.2022..
//

import Swinject

extension Resolver {
    
    func resolve<T>(type: T.Type = T.self) -> T {
        guard let instance = self.resolve(T.self) else {
            fatalError("Implementation for type \(T.self) not registered to \(self).")
        }
        return instance
    }
}
