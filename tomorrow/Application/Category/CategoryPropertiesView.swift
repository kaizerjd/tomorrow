//
// Created by JD Bartee on 1/23/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

class CategoryPropertiesViewController: UIViewController, UITextFieldDelegate {


  let pageView = UIView()
  let stackView = UIStackView()
  let nameField = UITextField()
  let colorStack = UIStackView()
  let colorLabel = UILabel()
  let colorView = UIView()
  let colorPicker: UIPickerView = UIPickerView()
  let iconLabel = UILabel()
  let iconCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
  let button: UIButton = UIButton(type: .roundedRect)

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

    pageView.backgroundColor = .darkGray
    pageView.layer.cornerRadius = 10.0
    pageView.translatesAutoresizingMaskIntoConstraints = false

    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false

    nameField.placeholder = "Category Name"
    nameField.borderStyle = .roundedRect
    nameField.textColor = .lightGray
    nameField.returnKeyType = .next
    nameField.delegate = self

    colorStack.axis = .horizontal
    colorStack.distribution = .fill
    colorStack.alignment = .fill

    colorLabel.text = "Color: "
    colorLabel.sizeToFit()

    colorView.backgroundColor = .green
    colorView.layer.cornerRadius = 5
    colorView.layer.borderColor = UIColor.lightGray.cgColor
    colorView.layer.borderWidth = 1

    colorStack.addArrangedSubview(colorLabel)
    colorStack.addArrangedSubview(colorView)
    //colorStack.addArrangedSubview(colorPicker)

    iconLabel.text = "Icon"
    iconLabel.sizeToFit()

    let layout = iconCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: 30, height: 30)
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10

    button.setTitle("Add New Category", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.titleLabel?.sizeToFit()
    button.addTarget(self, action: #selector(self.buttonClicked(_:)), for: .touchUpInside)

    stackView.addArrangedSubview(nameField)
    stackView.addArrangedSubview(colorStack)
    stackView.addArrangedSubview(iconLabel)
    stackView.addArrangedSubview(iconCollectionView)
    stackView.addArrangedSubview(button)

    pageView.addSubview(stackView)
    pageView.layoutSubviews()

    view.addSubview(pageView)
    view.setNeedsUpdateConstraints()

  }

  override func updateViewConstraints() {
    super.updateViewConstraints()

    //pageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    pageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
    pageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    pageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    stackView.topAnchor.constraint(equalTo: pageView.topAnchor, constant: 10).isActive = true
    stackView.bottomAnchor.constraint(equalTo: pageView.bottomAnchor, constant: -10).isActive = true
    stackView.leadingAnchor.constraint(equalTo: pageView.leadingAnchor, constant: 10).isActive = true
    stackView.trailingAnchor.constraint(equalTo: pageView.trailingAnchor, constant: -10).isActive = true

  }

  func buttonClicked(_ sender: UIButton) {
    self.dismiss(animated: true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }


}
