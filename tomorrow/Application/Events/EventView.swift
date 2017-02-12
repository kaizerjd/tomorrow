//
// Created by JD Bartee on 1/16/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import  UIKit
//import CalendarLib

class EventView : MGCEventView {


  private var _title: String
  private var _color: UIColor

  private var stackView: UIStackView
  private var titleLabel: UILabel
  private var bodyView: UIView
  
  var title: String {
    get {
      return _title
    }
    set {
      _title = newValue
      updateTitle()
    }
  }

  var color: UIColor {
    get {
      return _color
    }
    set {
      _color = newValue
      udateColor()
    }
  }

  override init(frame: CGRect) {

    _title = "EMPTY"
    _color = UIColor.green

    stackView = UIStackView(frame: frame)
    bodyView = UIView()
    titleLabel = UILabel()

    super.init(frame: frame)

    backgroundColor = .clear

    titleLabel.font = UIFont.systemFont(ofSize: 10)
    titleLabel.text = _title
    titleLabel.backgroundColor = _color

    bodyView.backgroundColor = _color.withAlphaComponent(0.50)

    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false

    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(bodyView)

    stackView.layoutSubviews()

    self.contentMode = UIViewContentMode.redraw
    addSubview(stackView)

    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
    stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

  }

  required init?(coder aCoder: NSCoder) {

    _title = "EMPTY"
    _color = UIColor.orange

    stackView = UIStackView(coder: aCoder)
    bodyView = UIView()
    titleLabel = UILabel()

    super.init(coder: aCoder)

    titleLabel.font = UIFont.systemFont(ofSize: 10)
    titleLabel.text = _title
    titleLabel.backgroundColor = _color

    bodyView.backgroundColor = _color.withAlphaComponent(0.50)

    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false

    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(bodyView)
    stackView.layoutSubviews()

    self.contentMode = UIViewContentMode.redraw
    addSubview(stackView)
  }

  func udateColor() {
      bodyView.backgroundColor = _color.withAlphaComponent(0.50)
      titleLabel.backgroundColor = _color
  }

  func updateTitle() {
      titleLabel.text = _title
  }

  // MARK: NSCopying protocol

  override func copy(with zone: NSZone?) -> Any {
    let cell = super.copy(with: zone) as! EventView
    cell.title = self.title
    cell.color = self.color
    return cell
  }

}
