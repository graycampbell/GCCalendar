//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

internal final class GCCalendarWeekView: UIStackView
{
    // MARK: - Properties
    
    private weak var viewController: GCCalendarViewController!
    
    internal var dates: [NSDate?]!
    
    private var dayViews: [GCCalendarDayView] = []
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController, dates: [NSDate?])
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addDayViews(dates: dates)
    }
    
    // MARK: - Visibility
    
    private func setVisibility()
    {
        if !self.viewController.pastDaysEnabled()
        {
            let firstDate = self.dates.filter { $0 != nil }.first
            
            if firstDate != nil
            {
                let weekBeforeToday = self.viewController.calendar.dateByAddingUnit(.WeekOfYear, value: -1, toDate: NSDate(), options: .MatchStrictly)!
                
                self.hidden = self.viewController.calendar.isDate(firstDate!!, equalToDate: weekBeforeToday, toUnitGranularity: .WeekOfYear)
            }
        }
    }
    
    // MARK: - Pan Gesture Recognizer
    
    internal func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    // MARK: - Day Views
    
    private func addDayViews(dates dates: [NSDate?])
    {
        self.dates = dates
        
        for date in self.dates
        {
            let dayView = GCCalendarDayView(viewController: self.viewController, date: date)
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
        
        self.setVisibility()
    }
    
    internal func update(newDates newDates: [NSDate?])
    {
        self.dates = newDates
        
        for (index, date) in self.dates.enumerate()
        {
            self.dayViews[index].update(newDate: date)
        }
        
        self.setVisibility()
    }
    
    internal func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].selected()
    }
}
