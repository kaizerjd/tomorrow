//
// Created by JD Bartee on 1/10/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit

//import CalendarLib


class DayPlannerViewController: MGCDayPlannerViewController {


  var _dataSource: DayPlannerViewDataSource?

  override func viewDidLoad() {

    let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
    let end = Calendar.current.date(byAdding: .day, value: 1, to: start!)

    _dataSource = DayPlannerViewDataSource()

    let dpv: MGCDayPlannerView = dayPlannerView
    dpv.calendar = Calendar.current
    dpv.canMoveEvents = false
    dpv.delegate = self
    dpv.dateRange = MGCDateRange(start: start, end: end)
    dpv.dataSource = _dataSource
    dpv.dayHeaderHeight = 0
    dpv.backgroundView = UIView(frame: dpv.frame)
    dpv.backgroundView.backgroundColor = UIColor.darkGray
    dpv.hourSlotHeight = 50.0
    dpv.register(EventView.self, forEventViewWithReuseIdentifier: "event")

  }

  func printDateInfo(atPoint point: CGPoint) {
    let dpv: MGCDayPlannerView = dayPlannerView

    if let originDate = dpv.date(at: point, rounded: false) {
      print(Calendar.current.component(.day, from: originDate))
      print(originDate)
    }
  }

  func createEvent(atPoint point: CGPoint, ofCategory category: Category) {
    let dpv: MGCDayPlannerView = dayPlannerView
    let dataSource = _dataSource!

    if let originDate = dpv.date(at: point, rounded: false) {
      dataSource.addEvent(originDate, category: category)
    }
  }

  func getEventRectangle(atPoint point: CGPoint) -> CGRect? {
    let dpv: MGCDayPlannerView = dayPlannerView

    if point.y < dpv.dayHeaderHeight {
      return nil
    }

    let timeWidth = dpv.timeColumnWidth
    let origin = CGPoint(x: timeWidth, y: point.y)

    if let originDate = dpv.date(at: point, rounded: false) {

      let originRect = dpv.rectForNewEvent(of: .timedEventType, at: originDate)
      print("H: \(Calendar.current.component(.hour, from: originDate)) M: \(Calendar.current.component(.minute, from: originDate))")
      print("O: \(origin) C: \(originRect.origin)")


      var height: CGFloat = 0.0

      if let nextEvent = _dataSource!.getNextTimeEvent(originDate) {
        let nextDate = nextEvent.start
        let nextRect = dpv.rectForNewEvent(of: .timedEventType, at: nextDate)
        height = nextRect.origin.y - originRect.origin.y

      }

      if height == 0.0 || height > dpv.frame.height - originRect.origin.y {
        height = dpv.frame.height - originRect.origin.y
      }

      let rect = CGRect(x: originRect.origin.x, y: originRect.origin.y,
          width: originRect.width, height: height)

      return rect
    }

    return nil

  }

}

extension DayPlannerViewController {


  override func dayPlannerView(_ view: MGCDayPlannerView!, attributedStringFor mark: MGCDayPlannerTimeMark, time ti: TimeInterval) -> NSAttributedString! {

    let dateTime = Date(timeInterval: ti, since: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!)

    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"


    let timeString = formatter.string(from: dateTime)

    return NSAttributedString(string: timeString)

  }

}
