//
//  PendantNavigationController.swift
//  Pendant_Example
//
//  Created by Jeffrey hu on 2022/3/27.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PendantNavigationController: UINavigationController {
  
  override var shouldAutorotate: Bool {
    return self.topViewController?.shouldAutorotate ?? false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return self.topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }
  
}
