//
//  JSONPlaceholder.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 02.08.2022..
//

import Foundation

struct JSONPlaceholder: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }
}


enum JSONPlaceholderResult<JSONPlaceholder> {
    case success(JSONPlaceholder)
    case error(NetworkErrorConditions)
    
    var value : JSONPlaceholder? {
        switch self {
        case .error: return nil
        case .success(let response): return response
        }
    }
    
    var error : NetworkErrorConditions? {
        switch self {
        case .error(let error): return error
        case .success: return nil
        }
    }
}



struct NetworkErrorConditions: Error {
    let badUrl: String
    let dataCannotHandled: String
}
