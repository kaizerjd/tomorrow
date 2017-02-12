//
// Created by JD Bartee on 1/11/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
import UIKit
//import CalendarLib

class Event: NSObject {
  var title: String
  var start: Date
  var end: Date
  var type: MGCEventType
  var category: Category

  override init() {
    title = ""
    start = Date()
    end = Date()
    type = MGCEventType.timedEventType
    category = Category(called: "", withColor: .clear)
  }

  //func getEventView() -> MGCEventView {
  //
  //  let view = EventView()
  //view.title = self.title
  //view.color = UIColor.green
  //
  //  return view
  //}

  func getDateRange() -> MGCDateRange {
    let range = MGCDateRange(start: self.start, end: self.end)!
    return range
  }

}
