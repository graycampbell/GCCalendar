//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarWeekView: UIStackView
{
    // MARK: - Properties
    
    private var dates: [NSDate?]!
    
    var dayViews: [GCCalendarDayView] = []
    
    // MARK: - Initializers
    
    public convenience init(dates: [NSDate?])
    {
        self.init(frame: CGRectZero)
        
        self.dates = dates
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.addDayViews()
    }
}

// MARK: Day Views

extension GCCalendarWeekView
{
    private func addDayViews()
    {
        for date in self.dates
        {
            let dayView = GCCalendarDayView(date: date)
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
    
    func update(newDates newDates: [NSDate?])
    {
        self.dates = newDates
        
        for var i = 0; i < self.dayViews.count; i++
        {
            self.dayViews[i].update(newDate: newDates[i])
        }
    }
    
    func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].dayPressed()
    }
}
