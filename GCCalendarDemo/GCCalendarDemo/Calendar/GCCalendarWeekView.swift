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
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init()
    {
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: Day Views

extension GCCalendarWeekView
{
    func addDayViews()
    {
        let dayViewWidth: CGFloat = 35
        
        for var i = 0; i < Calendar.Header.weekdayLabels.count; i++
        {
            let dayView = GCCalendarDayView()
            
            self.addSubview(dayView)
            self.dayViews.append(dayView)
            
            dayView.layer.cornerRadius = dayViewWidth / 2
            
            dayView.widthConstraint = NSLayoutConstraint(i: dayView, a: .Width, c: dayViewWidth)
            dayView.heightConstraint = NSLayoutConstraint(i: dayView, a: .Height, c: dayViewWidth)
            dayView.centerXConstraint = NSLayoutConstraint(i: dayView, a: .CenterX, i: Calendar.Header.weekdayLabels[i])
            dayView.centerYConstraint = NSLayoutConstraint(i: dayView, a: .CenterY, i: self)
            
            self.superview!.superview!.addConstraints([dayView.widthConstraint, dayView.heightConstraint, dayView.centerXConstraint, dayView.centerYConstraint])
        }
    }
}
