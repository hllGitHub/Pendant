//
//  ViewController.swift
//  Pendant
//
//  Created by liangliang.hu on 03/04/2021.
//  Copyright (c) 2021 liangliang.hu. All rights reserved.
//

import UIKit
import Pendant

struct PendantUserDefaults {
  @UserDefault<Bool>(key: "isFirstLoggedIn", defaultValue: false)
  static var isFirstLoggedIn

  @UserDefault<Bool>(key: "isEnterGame", defaultValue: false, storage: UserDefaults.standard)
  var isEnterGame
}

class ViewController: UIViewController {
  @UserDefault<Bool>(key: "mark-as-read", defaultValue: true)
  var autoMarkMessageAsRead

  @UserDefault<Int>(key: "search-page-size", defaultValue: 20)
  var numberOfSearchResultsPerPage
  
  private lazy var pushOrientationButton: UIButton = {
    let button = UIButton(frame: CGRect.zero)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Push Orientation", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(pushOrientationViewController), for: .touchUpInside)
    return button
  }()
  
  private lazy var presentOrientationButton: UIButton = {
    let button = UIButton(frame: CGRect.zero)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Present Orientation", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.addTarget(self, action: #selector(presentOrientationViewController), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    colorHelperExample()
    userDefaultExample()
    orientationExample()
  }

  func colorHelperExample() {
    view.backgroundColor = .random
  }

  func userDefaultExample() {
    debugPrint("isFirstLoggedIn: \(String(describing: PendantUserDefaults.isFirstLoggedIn))")

    autoMarkMessageAsRead = nil
    numberOfSearchResultsPerPage = nil

    debugPrint("autoMarkMessageAsRead: \(String(describing: autoMarkMessageAsRead)), numberOfSearchResultsPerPage: \(String(describing: numberOfSearchResultsPerPage))")

    autoMarkMessageAsRead = false
    numberOfSearchResultsPerPage = 100

    debugPrint("autoMarkMessageAsRead: \(String(describing: autoMarkMessageAsRead)), numberOfSearchResultsPerPage: \(String(describing: numberOfSearchResultsPerPage))")
  }
  
  func orientationExample() {
    let stack = UIStackView(arrangedSubviews: [pushOrientationButton, presentOrientationButton])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.distribution = .fillEqually
    stack.alignment = .center
    stack.spacing = 10
    view.addSubview(stack)
    stack.frame = view.bounds
    
    NSLayoutConstraint.activate([
      stack.leftAnchor.constraint(equalTo: view.leftAnchor),
      stack.rightAnchor.constraint(equalTo: view.rightAnchor),
      stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      stack.heightAnchor.constraint(equalToConstant: 150)
    ])
  }
  
  @objc
  func pushOrientationViewController() {
    navigationController?.pushViewController(OrientationViewController(), animated: true)
  }
  
  @objc
  func presentOrientationViewController() {
    let orientationViewController = OrientationViewController()
    orientationViewController.modalPresentationStyle = .fullScreen
    navigationController?.present(orientationViewController, animated: true)
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override var shouldAutorotate: Bool {
    return false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
