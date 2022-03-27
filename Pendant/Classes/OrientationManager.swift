//
//  OrientationManager.swift
//  Pendant
//
//  Created by Jeffrey hu on 2022/3/27.
//

import Foundation
import CoreMotion
import UIKit

public enum DeviceOrientation: Int, Decodable {
  case portraitUp
  case landscapeLeft
  case portraitDown
  case landscapeRight
  
  func convertUIInterfaceOrientation() -> UIInterfaceOrientation {
    switch self {
    case .portraitUp:
      return .portrait
    case .landscapeLeft:
      return .landscapeRight
    case .portraitDown:
      return .portraitUpsideDown
    case .landscapeRight:
      return .landscapeRight
    }
  }
  
  /// Indicate current device is in the `Landscape` orientation
  public static var isLandscape: Bool {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    } else {
      return UIApplication.shared.statusBarOrientation.isLandscape
    }
  }
  
  /// Indicate current device is in the `Portrait` orientation
  public static var isPortrait: Bool {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? false
    } else {
      return UIApplication.shared.statusBarOrientation.isPortrait
    }
  }
}

public class OrientationManager {
  public static let shared = OrientationManager()
  
  let motionManager = CMMotionManager()
  
  /// The angle of device, default is `0`.
  var angle: Int = 0
  
  init() {
    listenMotion()
  }
  
  deinit {
    motionManager.stopDeviceMotionUpdates()
  }
  
  // Start listening the motion of device
  func listenMotion() {
    self.motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] (motion, error) in
      guard let self = self else {
        return
      }
      guard error == nil else {
        debugPrint("Can not get motion. The error is: \(String(describing: error)).")
        return
      }
      guard let motion = motion else {
        debugPrint("No invalid motion.")
        return
      }
      
      let gravityX = motion.gravity.x
      let gravityY = motion.gravity.y
      self.angle = Int(round(atan2(gravityX, gravityY) / .pi * 180.0 + 180.0))
    }
  }
}

extension OrientationManager {
  public func calculateOrientation(isLandscape: Bool) -> UIInterfaceOrientation? {
    // Calculate the rotation angle
    guard var orientation = DeviceOrientation(rawValue: (self.angle + 45) % 360 / 90) else {
      debugPrint("No invalid orientation. angle is \(self.angle).")
      return nil
    }
    
    // Get the direction of rotation
    if isLandscape {
      switch orientation {
      case .portraitUp:
        orientation = .landscapeLeft
      case .portraitDown:
        orientation = .landscapeRight
      default:
        break
      }
    } else {
      switch orientation {
      case .landscapeLeft:
        orientation = .portraitUp
      case .landscapeRight:
        orientation = .portraitDown
      default:
        break
      }
    }
    
    return orientation.convertUIInterfaceOrientation()
  }
  
  public func rotateOrientationForLandscape(isLandscape: Bool, animated: Bool = true) {
    // Calculate the rotation angle
    guard let calculateOrientation = calculateOrientation(isLandscape: isLandscape) else {
      return
    }
    
    rotateInterfaceOrientation(orientation: calculateOrientation, animated: animated)
  }
  
  public func rotateInterfaceOrientation(orientation: UIInterfaceOrientation, animated: Bool = true) {
    // Set rotation
    UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    UIView.setAnimationsEnabled(animated)
    // Keep screen orientation and device orientation consistent.
    UIViewController.attemptRotationToDeviceOrientation()
  }
}
