//
//  MarvelResponse.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation
import Moya

public enum Marvel {
    // 1
    static private let publicKey = "ffc09e4c41b35eba39d92383c06b01dc"
    static private let privateKey = "52f3765e4a96eadda42e77e402e82cba86d2f81d"
    
    // 2
    case comics
}

extension Marvel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .comics: return "/comics"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .comics: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        
        let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash] as [String : Any]

        var parameters: [String : Any] = ["format": "comic",
                          "formatType": "comic",
                          "orderBy": "-onsaleDate",
                          "dateDescriptor": "lastWeek",
                          "limit": 50]
        
        parameters.update(other: authParams)
        
        switch self {
        case .comics:
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}


struct MarvelResponse<T: Codable>: Codable {
  let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
  let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
  let data: T
}
