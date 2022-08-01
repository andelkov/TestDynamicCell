//
//  MarvelResponse.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Moya
import UIKit

public enum MarvelAPI {
    case comics
}

extension MarvelAPI: TargetType {
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
        let hash = (ts + NetworkImpl.privateKey + NetworkImpl.publicKey).md5
        
        let authParams = ["apikey": NetworkImpl.publicKey, "ts": ts, "hash": hash] as [String : Any]

        var parameters: [String : Any] = ["format": "comic",
                          "formatType": "comic",
                          "orderBy": "-onsaleDate",
                          "dateDescriptor": "lastWeek",
                          "limit": 100]
        
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

