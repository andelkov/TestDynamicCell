//
//  PlaceholderAPI.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 02.08.2022..
//

import Foundation
import Moya

fileprivate var acceptableStatusCodes: [Int] { return Array(200..<500) }

public enum JSONPlaceholderAPI {
    case upload
}

extension JSONPlaceholderAPI: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://jsonplaceholder.typicode.com")!
  }

  // 2
    public var path: String {
        switch self {
        case .upload: return "/posts"
        }
    }

  // 3
  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    }
  }

  // 4
  public var sampleData: Data {
    return Data()
  }

  // 5
  public var task: Task {
    switch self {
    case .upload:
        
        let mockRequest = JSONPlaceholder(userId: 1, id: 101, title: "Custom title", body: "Custom body")
        
        return .requestJSONEncodable(mockRequest)
    }
  }

  // 6
  public var headers: [String : String]? {
      return ["Content-type": "application/json; charset=UTF-8"]
  }

  // 7
  public var validationType: ValidationType {
      return .successCodes//.customCodes(acceptableStatusCodes)
  }
}


