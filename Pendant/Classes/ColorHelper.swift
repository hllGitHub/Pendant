//
//  ColorHelper.swift
//  Pendant
//
//  Created by liangliang hu on 2022/2/15.
//

import Foundation
import UIKit

public extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
  }

  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

    if hexFormatted.hasPrefix("#") {
      hexFormatted = String(hexFormatted.dropFirst())
    }

    assert(hexFormatted.count == 6, "Invalid hex code used.")

    var rgbValue: UInt64 = 0
    Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

  static var random: UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
  }
}
