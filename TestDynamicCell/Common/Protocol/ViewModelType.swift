//
//  ViewModelType.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 21.07.2022..
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
