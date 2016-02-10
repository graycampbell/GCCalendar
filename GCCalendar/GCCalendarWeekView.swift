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
    
    private var delegate: GCCalendarDelegate!
    private var dayViews: [GCCalendarDayView] = []
    
    // MARK: - Initializers
    
    convenience init(delegate: GCCalendarDelegate, dates: [NSDate?])
    {
        self.init(frame: CGRectZero)
        
        self.delegate = delegate
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.addDayViews(dates: dates)
    }
}

// MARK: - Day Views

extension GCCalendarWeekView
{
    private func addDayViews(dates dates: [NSDate?])
    {
        for date in dates
        {
            let dayView = GCCalendarDayView(delegate: self.delegate, date: date)
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
    
    func update(newDates newDates: [NSDate?])
    {
        for (index, date) in newDates.enumerate()
        {
            self.dayViews[index].update(newDate: date)
        }
    }
    
    func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].dayPressed()
    }
}
