//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarMonthView: UIStackView {
    
    // MARK: Properties
    
    fileprivate var configuration: GCCalendarConfiguration!
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    fileprivate var weekViews: [GCCalendarWeekView] {
        
        return self.arrangedSubviews as! [GCCalendarWeekView]
    }
    
    fileprivate var dates: [[Date?]] {
        
        let numberOfWeekdays = self.configuration.calendar.maximumRange(of: .weekday)!.count
        let numberOfWeeks = self.configuration.calendar.maximumRange(of: .weekOfMonth)!.count
        
        var newDates = [[Date?]](repeating: [Date?](repeating: nil, count: numberOfWeekdays), count: numberOfWeeks)
        
        var date: Date = self.startDate
        
        repeat {
            
            let weekday = self.configuration.calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date)!
            var weekOfMonth = self.configuration.calendar.ordinality(of: .weekOfMonth, in: .month, for: date)!
            
            if self.configuration.calendar.ordinality(of: .weekOfMonth, in: .month, for: self.startDate)! != 0 {
                
                weekOfMonth -= 1
            }
            
            newDates[weekOfMonth][weekday - 1] = date
            
            date = self.configuration.calendar.date(byAdding: .day, value: 1, to: date)!
            
        } while self.configuration.calendar.isDate(date, equalTo: self.startDate, toGranularity: .month)
        
        return newDates
    }
    
    internal var startDate: Date! {
        
        didSet {
            
            self.arrangedSubviews.isEmpty ? self.addWeekViews() : self.updateWeekViews()
        }
    }
    
    internal func contains(date: Date) -> Bool {
        
        return self.configuration.calendar.isDate(self.startDate, equalTo: date, toGranularity: .month)
    }
    
    // MARK: Initializers
    
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        super.init(frame: CGRect.zero)
        
        self.configuration = configuration
        
        self.axis = .vertical
        self.distribution = .fillEqually
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarMonthView {
    
    func addPanGestureRecognizer(target: Any?, action: Selector?) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Week Views

fileprivate extension GCCalendarMonthView {
    
    func addWeekViews() {
        
        for dates in self.dates {
            
            let weekView = GCCalendarWeekView(configuration: self.configuration)
            
            weekView.dates = dates
            
            self.addArrangedSubview(weekView)
        }
    }
    
    func updateWeekViews() {
        
        for (index, dates) in self.dates.enumerated() {
            
            self.weekViews[index].dates = dates
        }
    }
}

// MARK: - Selected Date

internal extension GCCalendarMonthView {
    
    func select(date: Date? = nil) {
        
        let newDate: Date = date ?? self.startDate
        var weekOfMonth = self.configuration.calendar.ordinality(of: .weekOfMonth, in: .month, for: newDate)!
        
        if self.configuration.calendar.ordinality(of: .weekOfMonth, in: .month, for: self.startDate)! != 0 {
            
            weekOfMonth -= 1
        }
        
        self.weekViews[weekOfMonth].select(date: newDate)
    }
}
