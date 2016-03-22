//
//  GCCalendarDayViewTests.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/21/16.
//

import XCTest
@testable import GCCalendar

class GCCalendarDayViewTests: XCTestCase
{
    private var viewController = GCCalendarViewController()
    
    func testUpdate()
    {
        let newDate = NSDate()
        let dayView = GCCalendarDayView(viewController: self.viewController, date: nil)
        
        XCTAssertEqual(dayView.date, nil)
        
        dayView.update(newDate: newDate)
        
        XCTAssertEqual(dayView.date, newDate)
    }
}
