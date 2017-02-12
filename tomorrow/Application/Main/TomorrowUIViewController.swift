//
// Created by JD Bartee on 1/15/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit
//import CalendarLib

class TomorrowUIViewController: UIViewController {
  var tapGestureRecognizer: UITapGestureRecognizer?
  var longPressGestureRecognizer: UILongPressGestureRecognizer?

  var stackView: UIStackView?
  var dayView: DayPlannerViewController?
  var categoriesView: CategoryCollectionViewController?
  var dragAndDropView: EventViewForPanning?
  var didSetupContstraints: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController!.setToolbarHidden(false, animated: true)
    self.title = "<#2mrrw>"

    stackView = UIStackView()
    stackView!.axis = .vertical
    stackView!.distribution = .fill
    stackView!.alignment = .fill
    stackView!.translatesAutoresizingMaskIntoConstraints = false

    dayView = DayPlannerViewController()
    addChildViewController(dayView!)
    stackView!.addArrangedSubview(dayView!.view)
    dayView!.didMove(toParentViewController: self)

    categoriesView = CategoryCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.self())
    addChildViewController(categoriesView!)
    stackView!.addArrangedSubview(categoriesView!.view)
    categoriesView!.didMove(toParentViewController: self)

    view.addSubview(stackView!)
    view.setNeedsUpdateConstraints()

    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

    longPressGestureRecognizer = UILongPressGestureRecognizer()
    longPressGestureRecognizer!.addTarget(self, action: #selector(self.handleLongPress(_:)))
    longPressGestureRecognizer!.minimumPressDuration = 0.2

    view.addGestureRecognizer(tapGestureRecognizer!)
    view.addGestureRecognizer(longPressGestureRecognizer!)
  }

  override func updateViewConstraints() {
    super.updateViewConstraints()

    stackView!.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    stackView!.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    stackView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    stackView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

  }

  func handleLongPress(_ sender: UILongPressGestureRecognizer) {

    let state = sender.state

    switch state {
    case .began: //If press is over a category view create dragable view
      let view = sender.view
      let loc = sender.location(in: view)
      if let categoryView = view?.hitTest(loc, with: nil) as? CategoryView {
        dragAndDropView = EventViewForPanning(category: categoryView.category)
        dragAndDropView!.frame = CGRect(origin: loc, size: CGSize(width: 80, height: 80))
        dragAndDropView!.center = loc
        //dragAndDropView!.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        view!.addSubview(dragAndDropView!)

      }
      break

    case .changed: //Move/Animate dragable view
      let view = sender.view
      let loc = sender.location(in: view)
      if let dragAndDropView = dragAndDropView {

        let convertedLoc = view!.convert(loc, to: dayView!.dayPlannerView)
        var rect: CGRect? = nil

        if dayView!.dayPlannerView.frame.intersects(CGRect(origin: convertedLoc,
            size: CGSize.zero)) {
          if let tempRect = dayView!.getEventRectangle(atPoint: convertedLoc) {
            rect = view!.convert(tempRect, from: dayView!.dayPlannerView)
          }
        }
        if rect == nil {
          rect = CGRect(origin: CGPoint(x: loc.x - 40, y: loc.y - 40),
              size: CGSize(width: 80, height: 80))
        }

        UIView.animate(withDuration: 0.1, animations: {
          dragAndDropView.frame = rect!
        })
      }
      break

    case .ended: //Move ended.  TODO: Do things
      let view = sender.view
      let loc = sender.location(in: view)

      if let dragAndDropView = dragAndDropView {
        let convertedLoc = view!.convert(loc, to: dayView!.dayPlannerView)

        if dayView!.dayPlannerView.frame.intersects(CGRect(origin: convertedLoc, size: CGSize.zero)) {
          dayView!.createEvent(atPoint: convertedLoc, ofCategory: dragAndDropView.category)
          dayView!.printDateInfo(atPoint: convertedLoc)
        }

        dragAndDropView.removeFromSuperview()
      }

      dragAndDropView = nil
      break

    default:
      break
    }
  }

  func handleTap(_ sender: UIGestureRecognizer) {

    let view = sender.view
    let loc = sender.location(in: view)
    if let _ = view?.hitTest(loc, with: nil) as? AddCategoryView {

      let catPropView = CategoryPropertiesViewController()
      catPropView.modalPresentationStyle = .overCurrentContext
      catPropView.preferredContentSize = CGSize(width: 200, height: 200)
      self.present(catPropView, animated: true, completion: nil)

    }
  }
}
