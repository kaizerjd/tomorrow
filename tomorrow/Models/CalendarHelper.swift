//
// Created by JD Bartee on 2/11/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation

class CalendarHelper {

  static func getTomorrow(forDate date: Date) -> Date? {
    var midnight = Calendar.current.date(bySettingHour: 0,minute: 0,second: 0, of: date)!
    var tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: midnight)!

    return tomorrow
  }
}
