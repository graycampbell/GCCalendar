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
    fileprivate var viewController = GCCalendarViewController()
    
    func testUpdate()
    {
        let dates = [Date?](repeating: nil, count: 7)
        let newDates = [Date?](repeating: Date(), count: 7)
        
        let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
        
        for (index, date) in weekView.dates.enumerated()
        {
            XCTAssertEqual(date, dates[index])
        }
        
        weekView.update(newDates: newDates)
        
        for (index, date) in weekView.dates.enumerated()
        {
            XCTAssertEqual(date, newDates[index])
        }
    }
}
