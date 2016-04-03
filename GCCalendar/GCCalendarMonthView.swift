//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarMonthView: UIStackView, UIGestureRecognizerDelegate
{
    // MARK: Properties
    
    private let viewController: GCCalendarViewController!
    
    internal var startDate: NSDate!
    
    private var weekViews: [GCCalendarWeekView] = []
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return self.viewController.calendar.isDate(self.startDate, equalToDate: NSDate(), toUnitGranularity: .Month)
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
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    internal init(viewController: GCCalendarViewController, startDate: NSDate)
    {
        self.viewController = viewController
        
        super.init(frame: CGRectZero)
        
        self.startDate = startDate
        
        self.axis = .Vertical
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekViews()
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarMonthView
{
    // MARK: Creation
    
    internal func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Week Views

internal extension GCCalendarMonthView
{
    // MARK: Creation
    
    private func addWeekViews()
    {
        for dates in self.dates
        {
            let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
            
            self.addArrangedSubview(weekView)
            self.weekViews.append(weekView)
        }
    }
}

// MARK: - Start Date & Selected Date

extension GCCalendarMonthView
{
    // MARK: Start Date
    
    internal func update(newStartDate newStartDate: NSDate)
    {
        self.startDate = newStartDate
        
        for (index, dates) in self.dates.enumerate()
        {
            self.weekViews[index].update(newDates: dates)
        }
    }
    
    // MARK: Selected Date
    
    internal func setSelectedDate()
    {
        let selectedDate = self.containsToday ? NSDate() : self.startDate
        
        let selectedDateComponents = self.viewController.calendar.components([.WeekOfMonth, .Weekday], fromDate: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday)
    }
}
