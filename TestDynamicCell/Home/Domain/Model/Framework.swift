//
//  Framework.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 14.07.2022..
//

import Foundation

struct Framework: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let urlString: String
    let description: String
}
