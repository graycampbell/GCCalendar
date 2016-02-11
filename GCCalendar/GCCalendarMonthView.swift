//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

internal final class GCCalendarMonthView: UIStackView, UIGestureRecognizerDelegate
{
    // MARK: - Properties
    
    internal var startDate: NSDate!
    
    private var viewController: GCCalendarViewController!
    private var weekViews: [GCCalendarWeekView] = []
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController, startDate: NSDate)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        self.startDate = startDate
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = .Vertical
        self.distribution = .FillEqually
        
        self.addWeekViews()
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarMonthView
{
    internal func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer.addTarget(target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - UIGestureRecognizerDelegate

internal extension GCCalendarMonthView
{
    internal override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let pan = gestureRecognizer as! UIPanGestureRecognizer
        
        return pan.velocityInView(pan.view!).x > pan.velocityInView(pan.view!).y
    }
}

// MARK: - Week Views

internal extension GCCalendarMonthView
{
    private func addWeekViews()
    {
        for dates in self.dates
        {
            let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
            
            self.addArrangedSubview(weekView)
            self.weekViews.append(weekView)
        }
    }
    
    private var dates: [[NSDate?]] {
        
        var date: NSDate? = self.startDate
        
        let numberOfWeekdays = self.viewController.currentCalendar.maximumRangeOfUnit(.Weekday).length
        let numberOfWeeks = self.viewController.currentCalendar.maximumRangeOfUnit(.WeekOfMonth).length
        
        let week = [NSDate?](count: numberOfWeekdays, repeatedValue: nil)
        
        var newDates = [[NSDate?]](count: numberOfWeeks, repeatedValue: week)
        
        while date != nil
        {
            let dateComponents = self.viewController.currentCalendar.components([.Month, .WeekOfMonth, .Weekday, .Day], fromDate: date!)
            
            newDates[dateComponents.weekOfMonth - 1][dateComponents.weekday - 1] = date
            
            if let newDate = self.viewController.currentCalendar.dateByAddingUnit(.Day, value: 1, toDate: date!, options: .MatchStrictly)
            {
                let newDateComponents = self.viewController.currentCalendar.components(.Month, fromDate: newDate)
                
                date = (newDateComponents.month == dateComponents.month) ? newDate : nil
            }
        }
        
        return newDates
    }
    
    internal func update(newStartDate newStartDate: NSDate)
    {
        self.startDate = newStartDate
        
        for (index, dates) in self.dates.enumerate()
        {
            self.weekViews[index].update(newDates: dates)
        }
    }
    
    internal func setSelectedDate()
    {
        let today = NSDate()
        
        let selectedDate = self.viewController.currentCalendar.isDate(self.startDate, equalToDate: today, toUnitGranularity: .Month) ? today : self.startDate
        
        let selectedDateComponents = self.viewController.currentCalendar.components([.WeekOfMonth, .Weekday], fromDate: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday)
    }
}
