//
// Created by JD Bartee on 1/15/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

class CategoryView: UIView {
  let category: Category

  init(category category: Category) {
    self.category = category
    super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    setupView()
  }

  required  init?(coder aCoder: NSCoder) {
    category = Category(called: "", withColor: .white)
    super.init(coder: aCoder)
    setupView()
  }

  func setupView() {
    self.backgroundColor = category.color.withAlphaComponent(0.50)
    self.layer.cornerRadius = 10.0

    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
    label.text = category.title.substring(to: category.title.index(category.title.startIndex, offsetBy: 1))
    label.textColor = UIColor.black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 40)

    label.center = self.center
    self.addSubview(label)
  }
}