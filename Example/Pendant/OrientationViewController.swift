//
//  OrientationViewController.swift
//  Pendant_Example
//
//  Created by Jeffrey hu on 2022/3/27.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Pendant

class OrientationViewController: UIViewController {
  
  private lazy var dismissButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Dismiss Orientation", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(dismissOrientation), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .cyan
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    addDismissButtonIfNeed()
    rotateScreenIfNeed()
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return isLandscape ? .landscape : .portrait
  }
  
  var isLandscape: Bool = true
  
  func rotateScreenIfNeed() {
      // present 和 dismiss 时会触发页面转动。对于 push 和 pop 操作不会被动触发页面转动，需要手动 setOrientation 来触发
    guard self.presentingViewController == nil, DeviceOrientation.isLandscape != isLandscape else {
      return
    }
    
    OrientationManager.shared.rotateOrientationForLandscape(isLandscape: isLandscape)
  }
  
  func addDismissButtonIfNeed() {
    guard self.presentingViewController != nil, !view.subviews.contains(dismissButton) else {
      return
    }
    
    view.addSubview(dismissButton)
    
    NSLayoutConstraint.activate([
      dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      dismissButton.widthAnchor.constraint(equalToConstant: 200),
      dismissButton.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  @objc
  func dismissOrientation() {
    guard self.presentingViewController != nil else {
      return
    }
    
    self.dismiss(animated: true)
  }
  
}
