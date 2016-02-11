//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

internal final class GCCalendarWeekView: UIStackView
{
    // MARK: - Properties
    
    private var viewController: GCCalendarViewController!
    private var dayViews: [GCCalendarDayView] = []
    
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController, dates: [NSDate?])
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.addDayViews(dates: dates)
    }
    
    // MARK: - Day Views
    
    private func addDayViews(dates dates: [NSDate?])
    {
        for date in dates
        {
            let dayView = GCCalendarDayView(viewController: self.viewController, date: date)
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
    
    internal func update(newDates newDates: [NSDate?])
    {
        for (index, date) in newDates.enumerate()
        {
            self.dayViews[index].update(newDate: date)
        }
    }
    
    internal func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].daySelected()
    }
}
