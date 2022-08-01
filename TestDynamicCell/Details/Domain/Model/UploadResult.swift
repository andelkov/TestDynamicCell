//
//  File.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 31.07.2022..
//

import Foundation

struct UploadResult: Codable, CustomDebugStringConvertible {
  let deletehash: String
  let link: URL

  var debugDescription: String {
    return "<UploadResult:\(deletehash)> \(link)"
  }
}
