//
// Created by JD Bartee on 1/21/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import  UIKit

class CategoryCollectionViewController: UICollectionViewController {

  var _dataSource: UICollectionViewDataSource?

    override func viewDidLoad() {

      _dataSource = CategoryDataSource()

      collectionView!.dataSource = _dataSource!
      collectionView!.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")

      let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
      layout.itemSize = CGSize(width: 70, height: 70)
      layout.scrollDirection = .horizontal
      layout.minimumInteritemSpacing = 10
      layout.minimumLineSpacing = 10
      layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)

      collectionView!.heightAnchor.constraint(equalToConstant: 90).isActive = true

      collectionView!.reloadData()
    }


}