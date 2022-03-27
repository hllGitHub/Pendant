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

  override func viewDidLoad() {
    super.viewDidLoad()

    colorHelperExample()
    userDefaultExample()
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

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
