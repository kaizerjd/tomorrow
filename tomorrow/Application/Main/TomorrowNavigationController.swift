//
// Created by JD Bartee on 1/21/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

class TomorrowNavigationController: UINavigationController {

  var mainViewController: UIViewController?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationBar.barStyle = .blackOpaque
    self.toolbar.barStyle = .blackOpaque

    mainViewController = TomorrowUIViewController()

    self.show(mainViewController!, sender: self)
  }



}