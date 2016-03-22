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
    private var viewController = GCCalendarViewController()
    
    func testUpdate()
    {
        let components = self.viewController.calendar.components([.Day, .Month, .Year], fromDate: self.viewController.selectedDate)
        components.day = 1
        
        let startDate = self.viewController.calendar.dateFromComponents(components)!
        let newStartDate = self.viewController.calendar.nextDateAfterDate(startDate, matchingUnit: .Day, value: 1, options: .MatchStrictly)!
        
        let monthView = GCCalendarMonthView(viewController: self.viewController, startDate: startDate)
        
        XCTAssertEqual(monthView.startDate, startDate)
        
        monthView.update(newStartDate: newStartDate)
        
        XCTAssertEqual(monthView.startDate, newStartDate)
    }
}
