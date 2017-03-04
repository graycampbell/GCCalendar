//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarMonthView: UIStackView, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    fileprivate var viewController: GCCalendarViewController!
    
    internal var startDate: Date!
    
    fileprivate var weekViews: [GCCalendarWeekView] = []
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return (self.viewController.calendar as NSCalendar).isDate(self.startDate, equalTo: Date(), toUnitGranularity: .month)
    }
    
    fileprivate var dates: [[Date?]] {
        
        var date: Date? = self.startDate
        
        let numberOfWeekdays = (self.viewController.calendar as NSCalendar).maximumRange(of: .weekday).length
        let numberOfWeeks = (self.viewController.calendar as NSCalendar).maximumRange(of: .weekOfMonth).length
        
        let week = [Date?](repeating: nil, count: numberOfWeekdays)
        
        var newDates = [[Date?]](repeating: week, count: numberOfWeeks)
        
        while date != nil {
            
            let dateComponents = self.viewController.calendar.dateComponents([.weekday, .weekOfMonth, .month, .year], from: date!)
            
            newDates[dateComponents.weekOfMonth! - 1][dateComponents.weekday! - 1] = date
            
            if let newDate = (self.viewController.calendar as NSCalendar).date(byAdding: .day, value: 1, to: date!, options: .matchStrictly) {
                
                let newDateComponents = self.viewController.calendar.dateComponents([.month], from: newDate)
                
                date = (newDateComponents.month == dateComponents.month) ? newDate : nil
            }
        }
        
        return newDates
    }
    
    // MARK: Initializers
    
    required internal init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    internal init(viewController: GCCalendarViewController, startDate: Date) {
        
        super.init(frame: CGRect.zero)
        
        self.viewController = viewController
        
        self.startDate = startDate
        
        self.axis = .vertical
        self.distribution = .fillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekViews()
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarMonthView {
    
    // MARK: Creation
    
    internal func addPanGestureRecognizer(_ target: AnyObject, action: Selector) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Week Views

private extension GCCalendarMonthView {
    
    // MARK: Creation
    
    func addWeekViews() {
        
        for dates in self.dates {
            
            let weekView = GCCalendarWeekView(viewController: self.viewController, dates: dates)
            
            self.addArrangedSubview(weekView)
            self.weekViews.append(weekView)
        }
    }
}

// MARK: - Start Date & Selected Date

internal extension GCCalendarMonthView {
    
    // MARK: Start Date
    
    internal func update(newStartDate: Date) {
        
        self.startDate = newStartDate
        
        for (index, dates) in self.dates.enumerated() {
            
            self.weekViews[index].update(newDates: dates)
        }
    }
    
    // MARK: Selected Date
    
    internal func setSelectedDate() {
        
        let selectedDate: Date = self.containsToday ? Date() : self.startDate
        
        let selectedDateComponents = self.viewController.calendar.dateComponents([.weekOfMonth, .weekday], from: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth! - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday!)
    }
}
