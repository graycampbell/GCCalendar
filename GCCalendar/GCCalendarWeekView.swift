//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarWeekView: UIView
{
    // MARK: - Properties
    
    private var dayViews: [GCCalendarDayView] = []
    
    // MARK: - Initializers
    
    public convenience init()
    {
        self.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: Day Views

extension GCCalendarWeekView
{
    func addDayViews(dates: [NSDate?])
    {
        let dayViewWidth: CGFloat = 35
        
        for var i = 0; i < Calendar.view.headerView.weekdayLabels.count; i++
        {
            let dayView = GCCalendarDayView(date: dates[i])
            
            self.addSubview(dayView)
            self.dayViews.append(dayView)
            
            dayView.layer.cornerRadius = dayViewWidth / 2
            
            dayView.widthConstraint = NSLayoutConstraint(i: dayView, a: .Width, c: dayViewWidth)
            dayView.heightConstraint = NSLayoutConstraint(i: dayView, a: .Height, c: dayViewWidth)
            dayView.centerXConstraint = NSLayoutConstraint(i: dayView, a: .CenterX, i: Calendar.view.headerView.weekdayLabels[i])
            dayView.centerYConstraint = NSLayoutConstraint(i: dayView, a: .CenterY, i: self)
            
            Calendar.view.addConstraints([dayView.widthConstraint, dayView.heightConstraint, dayView.centerXConstraint, dayView.centerYConstraint])
        }
    }
}
