//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarWeekView: UIStackView {
    
    // MARK: Properties
    
    fileprivate var viewController: GCCalendarViewController!
    
    internal var dates: [Date?]!
    
    fileprivate var dayViews: [GCCalendarDayView] = []
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return !self.dates.filter({ $0 != nil && self.viewController.calendar.isDateInToday($0!) }).isEmpty
    }
    
    // MARK: Initializers
    
    required internal init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    internal init(viewController: GCCalendarViewController, dates: [Date?]) {
        
        super.init(frame: CGRect.zero)
        
        self.viewController = viewController
        
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addDayViews(dates: dates)
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarWeekView {
    
    // MARK: Creation
    
    internal func addPanGestureRecognizer(_ target: AnyObject, action: Selector) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Day Views

private extension GCCalendarWeekView {
    
    // MARK: Creation

    func addDayViews(dates: [Date?]) {
        
        self.dates = dates
        
        for date in self.dates {
            
            let dayView = GCCalendarDayView(viewController: self.viewController, date: date)
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
}

// MARK: - Dates & Selected Date

internal extension GCCalendarWeekView {
    
    // MARK: Dates
    
    internal func update(newDates: [Date?]) {
        
        self.dates = newDates
        
        for (index, date) in self.dates.enumerated() {
            
            self.dayViews[index].update(newDate: date)
        }
    }
    
    // MARK: Selected Date
    
    internal func setSelectedDate(weekday: Int) {
        
        self.dayViews[weekday - 1].selected()
    }
}
