//
// Created by JD Bartee on 1/10/17.
// Copyright (c) 2017 CornerTwist. All rights reserved.
//

import Foundation
//import CalendarLib

class DayPlannerViewDataSource: NSObject, MGCDayPlannerViewDataSource {

  var events: [Event]
  var allDayEvents: [Event]

  override init() {

    do {
      events = [Event]()
      let event = Event()
      let category = Category(called: "test", withColor: .purple)
      let date = Date()
      let start = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: date)
      let end = Calendar.current.date(bySettingHour: 14, minute: 0, second: 0, of: date)

      event.title = "Better Test"
      event.start = start!
      event.end = end!
      event.category = category

      events.append(event)
    }

    do {
      allDayEvents = [Event]()
      let allDayEvent = Event()
      let category = Category(called: "all day", withColor: .gray)
      let date = Date()
      let start = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
      let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!

      allDayEvent.title = "I can do this all day"
      allDayEvent.start = start
      allDayEvent.end = end
      allDayEvent.type = MGCEventType.allDayEventType
      allDayEvent.category = category

      allDayEvents.append(allDayEvent)
    }
  }

  func dayPlannerView(_ view: MGCDayPlannerView!, numberOfEventsOf type: MGCEventType, at date: Date!)
          -> Int {


    if type == MGCEventType.timedEventType {
      return events.count
    }

    if type == MGCEventType.allDayEventType {
      return allDayEvents.count
    }

    return 0
  }

  func dayPlannerView(_ view: MGCDayPlannerView!, viewForEventOf type: MGCEventType, at index: UInt, date: Date!)
          -> MGCEventView! {
    let i: Int = Int(index)

    if type == MGCEventType.timedEventType {
      return getTimeEventView(events[i])
    }

    if type == MGCEventType.allDayEventType {
      return getAllDayEventView(allDayEvents[i])

    }

    return nil
  }

  func dayPlannerView(_ view: MGCDayPlannerView!, dateRangeForEventOf type: MGCEventType, at index: UInt, date: Date!)
          -> MGCDateRange! {
    let i: Int = Int(index)
    if type == MGCEventType.timedEventType {
      return events[i].getDateRange()
    }
    if type == MGCEventType.allDayEventType {
      return allDayEvents[i].getDateRange()
    }
    return nil
  }

  func getTimeEventView(_ event: Event) -> MGCEventView {
    let view = EventView()
    view.title = event.title
    view.color = event.category.color
    return view
  }

  func getAllDayEventView(_ event: Event) -> MGCEventView {
    let view = MGCStandardEventView()
    view.title = event.title
    view.color = event.category.color
    return view
  }

  func getNextTimeEvent(_ date: Date) -> Event? {
    var minDate: Date = Date.distantFuture
    var e: Event?

    for event in events {
      var range = event.getDateRange()
      if date < range.start {
        if range.start < minDate {
          minDate = range.start
          e = event
        }
      }
    }

    return e
  }

  func addEvent(_ date: Date, category category: Category) {
    var start = date
    var end = CalendarHelper.getTomorrow(forDate: date)

    if let nextEvent = getNextTimeEvent(date) {
      end = nextEvent.start
    }

    let newEvent = Event()
    newEvent.start = start
    newEvent.end = end!
    newEvent.category = category
    newEvent.title = category.title
    newEvent.type = .timedEventType

    events.append(newEvent)

  }

}
