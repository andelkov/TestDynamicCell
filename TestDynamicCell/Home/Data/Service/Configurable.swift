//
//  Configurable.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 15.07.2022..
//

import Foundation

protocol Configurable {
    associatedtype Data
    func configure(with data: Data)
}

