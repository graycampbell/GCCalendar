//
//  GCCalendarMonthViewTests.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/21/16.
//

import XCTest
@testable import GCCalendar

class GCCalendarMonthViewTests: XCTestCase
{
    fileprivate var viewController = GCCalendarViewController()
    
    func testUpdate()
    {
        let components = (self.viewController.calendar as NSCalendar).components([.day, .month, .year], from: self.viewController.selectedDate)
        components.day = 1
        
        let startDate = self.viewController.calendar.date(from: components)!
        let newStartDate = (self.viewController.calendar as NSCalendar).nextDate(after: startDate, matching: .day, value: 1, options: .matchStrictly)!
        
        let monthView = GCCalendarMonthView(viewController: self.viewController, startDate: startDate)
        
        XCTAssertEqual(monthView.startDate, startDate)
        
        monthView.update(newStartDate: newStartDate)
        
        XCTAssertEqual(monthView.startDate, newStartDate)
    }
}
