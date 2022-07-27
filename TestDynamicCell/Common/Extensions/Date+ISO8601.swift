//
//  Date+Ext.swift
//  TestDynamicCell
//
//  Created by Andjelko Vico on 27.07.2022..
//

import Foundation

extension Date {
  init?(ISO8601: String) {
    let isoFormatter = ISO8601DateFormatter()

    guard let date = isoFormatter.date(from: ISO8601) else { return nil }
    self = date
  }
}

