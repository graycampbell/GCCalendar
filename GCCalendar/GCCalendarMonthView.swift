//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

internal final class GCCalendarMonthView: UIStackView, UIGestureRecognizerDelegate
{
    // MARK: - Properties
    
    internal var startDate: NSDate!
    
    private weak var viewController: GCCalendarViewController!
    
    private var weekViews: [GCCalendarWeekView] = []
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController, startDate: NSDate)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        self.startDate = startDate
        
        self.axis = .Vertical
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekViews()
    }
    
    // MARK: - Visibility
    
    private func setVisibility()
    {
        if !self.viewController.pastDaysEnabled()
        {
            let monthBeforeToday = self.viewController.calendar.dateByAddingUnit(.Month, value: -1, toDate: NSDate(), options: .MatchStrictly)!
            
            self.hidden = self.viewController.calendar.isDate(self.startDate, equalToDate: monthBeforeToday, toUnitGranularity: .Month)
        }
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarMonthView
{
    internal func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
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
        
        self.setVisibility()
    }
    
    private var dates: [[NSDate?]] {
        
        var date: NSDate? = self.startDate
        
        let numberOfWeekdays = self.viewController.calendar.maximumRangeOfUnit(.Weekday).length
        let numberOfWeeks = self.viewController.calendar.maximumRangeOfUnit(.WeekOfMonth).length
        
        let week = [NSDate?](count: numberOfWeekdays, repeatedValue: nil)
        
        var newDates = [[NSDate?]](count: numberOfWeeks, repeatedValue: week)
        
        while date != nil
        {
            let dateComponents = self.viewController.calendar.components([.Weekday, .WeekOfMonth, .Month, .Year], fromDate: date!)
            
            newDates[dateComponents.weekOfMonth - 1][dateComponents.weekday - 1] = date
            
            if let newDate = self.viewController.calendar.dateByAddingUnit(.Day, value: 1, toDate: date!, options: .MatchStrictly)
            {
                let newDateComponents = self.viewController.calendar.components(.Month, fromDate: newDate)
                
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
        
        self.setVisibility()
    }
    
    internal func setSelectedDate(date: NSDate? = nil)
    {
        var selectedDate: NSDate!
        
        if date == nil
        {
            let today = NSDate()
            
            if self.viewController.calendar.isDate(self.startDate, equalToDate: self.viewController.selectedDate, toUnitGranularity: .Month)
            {
                selectedDate = self.viewController.selectedDate
            }
            else if self.viewController.calendar.isDate(self.startDate, equalToDate: today, toUnitGranularity: .Month)
            {
                selectedDate = today
            }
            else
            {
                selectedDate = self.startDate
            }
        }
        else
        {
            selectedDate = date
        }
        
        let selectedDateComponents = self.viewController.calendar.components([.WeekOfMonth, .Weekday], fromDate: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday)
    }
}
