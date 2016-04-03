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
    }
    
    internal func update(newDates newDates: [NSDate?])
    {
        self.dates = newDates
        
        for (index, date) in self.dates.enumerate()
        {
            self.dayViews[index].update(newDate: date)
        }
    }
    
    internal func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].selected()
    }
    
    internal var containsToday: Bool {
        
        return !self.dates.filter({ $0 != nil && self.viewController.calendar.isDateInToday($0!) }).isEmpty
    }
}
