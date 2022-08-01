//
//  ImgurAPI.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 29.07.2022..
//

import Foundation
import Moya

public enum ImgurAPI {
    
    static private let clientId = APIKeys.Imgur.clientID
    
    case upload(UIImage)
    case delete(String)
}

extension ImgurAPI: TargetType {
  // 1
  public var baseURL: URL {
    return URL(string: "https://api.imgur.com/3")!
  }

  // 2
    public var path: String {
        switch self {
        case .upload: return "/image"
        case .delete(let deleteHash): return "/image/\(deleteHash)"
        }
    }

  // 3
  public var method: Moya.Method {
    switch self {
    case .upload: return .post
    case .delete: return .delete
    }
  }

  // 4
  public var sampleData: Data {
    return Data()
  }

  // 5
  public var task: Task {
    switch self {
    case .upload(let image):
      let imageData = image.jpegData(compressionQuality: 1.0)!

      return .uploadMultipart([MultipartFormData(provider: .data(imageData),
                                                 name: "image",
                                                 fileName: "card.jpg",
                                                 mimeType: "image/jpg")])
    case .delete:
      return .requestPlain
    }
  }

  // 6
  public var headers: [String: String]? {
    return [
      "Authorization": "Client-ID \(ImgurAPI.clientId)",
      "Content-Type": "application/json"
    ]
  }

  // 7
  public var validationType: ValidationType {
    return .successCodes
  }
}
