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
    
    private var dates: [NSDate?]!
    private var dayViews: [GCCalendarDayView] = []
    
    // MARK: - Initializers
    
    public convenience init(dates: [NSDate?])
    {
        self.init(frame: CGRectZero)
        
        self.dates = dates
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addDayViews()
    }
}

// MARK: Day Views

extension GCCalendarWeekView
{
    private func addDayViews()
    {
        let widthMultiplier: CGFloat = 1.0 / CGFloat(Calendar.view.headerView.weekdayLabels.count)
        
        for var i = 0; i < Calendar.view.headerView.weekdayLabels.count; i++
        {
            let dayView = GCCalendarDayView(date: self.dates[i])
            
            self.addSubview(dayView)
            self.dayViews.append(dayView)
            
            if i == 0
            {
                self.addConstraintsForDayView(dayView, item: self, attribute: .Left, widthMultiplier: widthMultiplier)
            }
            else
            {
                self.addConstraintsForDayView(dayView, item: self.dayViews[i - 1], attribute: .Right, widthMultiplier: widthMultiplier)
            }
            
            dayView.addButton()
        }
    }
    
    private func addConstraintsForDayView(dayView: GCCalendarDayView, item: AnyObject, attribute: NSLayoutAttribute, widthMultiplier: CGFloat)
    {
        let top = NSLayoutConstraint(i: dayView, a: .Top, i: self)
        let left = NSLayoutConstraint(i: dayView, a: .Left, i: item, a: attribute)
        let width = NSLayoutConstraint(i: dayView, a: .Width, i: self, m: widthMultiplier)
        let height = NSLayoutConstraint(i: dayView, a: .Height, i: self)
        
        self.addConstraints([top, left, width, height])
    }
}
