//
// Created by JD Bartee on 1/16/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import  UIKit

class AddCategoryView: UIView {

  init() {

    super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
    self.layer.cornerRadius = 10.0
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    label.text = "+"
    label.textColor = UIColor.white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 40, weight: 10)

    label.center = self.center
    self.addSubview(label)
  }

  required init?(coder aCoder: NSCoder) {
    super.init(coder: aCoder)
  }
}