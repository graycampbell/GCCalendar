//
//  GCCalendarWeekViewTests.swift
//  GCCalendar
//
//  Created by Gray Campbell on 3/21/16.
//

import XCTest
@testable import GCCalendar

class GCCalendarWeekViewTests: XCTestCase
{
    private var viewController = GCCalendarViewController()
    
    func testUpdate()
    {
        let dates = [NSDate?](count: 7, repeatedValue: nil)
        let newDates = [NSDate?](count: 7, repeatedValue: NSDate())
        
        let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
        
        for (index, date) in weekView.dates.enumerate()
        {
            XCTAssertEqual(date, dates[index])
        }
        
        weekView.update(newDates: newDates)
        
        for (index, date) in weekView.dates.enumerate()
        {
            XCTAssertEqual(date, newDates[index])
        }
    }
}
