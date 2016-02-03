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
    private var dayViews: [GCCalendarDayView] = []
    
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
        for var i = 0; i < Calendar.view.headerView.weekdayLabels.count; i++
        {
            let dayView = GCCalendarDayView(date: self.dates[i])
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
}
