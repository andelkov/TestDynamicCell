//
//  Dictionary+Ext.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
