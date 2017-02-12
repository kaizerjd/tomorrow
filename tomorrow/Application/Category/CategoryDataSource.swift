//
// Created by JD Bartee on 1/15/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

class CategoryDataSource: NSObject, UICollectionViewDataSource {

  private var categories: [Category]

  override init() {
    categories = [Category]()
    super.init()

    for item in 0 ... 8 {
      let cat = Category(called: String(item), withColor: .blue)
      categories.append(cat)
    }
  }

  func numberOfSections(`in` collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)

    cell.subviews.forEach { (item) in
      item.removeFromSuperview()
    }

    var cellView: UIView
    if indexPath.row < categories.count {
      let category = categories[indexPath.row]
      cellView = CategoryView(category: category)
    } else {
      cellView = AddCategoryView()
    }
    cell.addSubview(cellView)

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count + 1
  }

  func addNewCategory(_ newCategory: Category) {
    categories.append(newCategory)
  }
}
