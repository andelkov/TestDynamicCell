//
//  APIKeys.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 29.07.2022..
//

import Foundation

struct APIKeys {
    static let Marvel = MarvelAPIKeys()
    static let Imgur =  ImgurAPIKeys()
}

struct MarvelAPIKeys {
    let publicKey = "ffc09e4c41b35eba39d92383c06b01dc"
    private let privateKey = "52f3765e4a96eadda42e77e402e82cba86d2f81d"
}

struct ImgurAPIKeys {
    let clientID = "b6b8f73e7fad8cc"
    let clientSecret = "534ce9121f7c9faac069b5531f2c09df2eff89d4"
}
