//
// Created by JD Bartee on 1/29/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

class EventViewForPanning: UIView {


  let category: Category

  init(category: Category) {
    self.category = category
    super.init(frame: CGRect.zero)

    setupView()
  }

  required init?(coder aCoder: NSCoder) {
    self.category = Category(called: "", withColor: .white)
    super.init(coder: aCoder)

    setupView()
  }

  func setupView() {
    backgroundColor = category.color.withAlphaComponent(0.50)
  }



}
