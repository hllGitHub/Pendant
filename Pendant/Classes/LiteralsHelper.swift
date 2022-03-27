//
//  LiteralsHelper.swift
//  Pendant
//
//  Created by liangliang hu on 2022/3/3.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(string: "\(value)")!
  }
}
