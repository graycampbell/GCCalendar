//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarWeekView: UIStackView
{
    // MARK: Properties
    
    private let viewController: GCCalendarViewController!
    
    internal var dates: [NSDate?]!
    
    private var dayViews: [GCCalendarDayView] = []
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return !self.dates.filter({ $0 != nil && self.viewController.calendar.isDateInToday($0!) }).isEmpty
    }
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    internal init(viewController: GCCalendarViewController, dates: [NSDate?])
    {
        self.viewController = viewController
        
        super.init(frame: CGRectZero)
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addDayViews(dates: dates)
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarWeekView
{
    // MARK: Creation
    
    internal func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Day Views

private extension GCCalendarWeekView
{
    // MARK: Creation

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
}

// MARK: - Dates & Selected Date

internal extension GCCalendarWeekView
{
    // MARK: Dates
    
    internal func update(newDates newDates: [NSDate?])
    {
        self.dates = newDates
        
        for (index, date) in self.dates.enumerate()
        {
            self.dayViews[index].update(newDate: date)
        }
    }
    
    // MARK: Selected Date
    
    internal func setSelectedDate(weekday weekday: Int)
    {
        self.dayViews[weekday - 1].selected()
    }
}
