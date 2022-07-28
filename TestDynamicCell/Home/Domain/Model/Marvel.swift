//
//  Marvel.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 28.07.2022..
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
  let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
  let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
