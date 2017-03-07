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
    
    fileprivate var configuration: GCCalendarConfiguration!
    
    fileprivate var weekViews = [GCCalendarWeekView]()
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return self.configuration.calendar.isDate(self.startDate, equalTo: Date(), toGranularity: .month)
    }
    
    fileprivate var dates: [[Date?]] {
        
        let numberOfWeekdays = self.configuration.calendar.maximumRange(of: .weekday)!.count
        let numberOfWeeks = self.configuration.calendar.maximumRange(of: .weekOfMonth)!.count
        
        var newDates = [[Date?]](repeating: [Date?](repeating: nil, count: numberOfWeekdays), count: numberOfWeeks)
        
        var date: Date = self.startDate
        
        repeat {
            
            let dateComponents = self.configuration.calendar.dateComponents([.weekday, .weekOfMonth, .month, .year], from: date)
            
            newDates[dateComponents.weekOfMonth! - 1][dateComponents.weekday! - 1] = date
            
            date = self.configuration.calendar.date(byAdding: .day, value: 1, to: date)!
            
        } while self.configuration.calendar.isDate(date, equalTo: self.startDate, toGranularity: .month)
        
        return newDates
    }
    
    var startDate: Date! {
        
        didSet {
            
            self.weekViews.isEmpty ? self.addWeekViews() : self.updateWeekViews()
        }
    }
    
    // MARK: Initializers
    
    required internal init(coder: NSCoder) {
        
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
    
    internal func addPanGestureRecognizer(target: Any?, action: Selector?) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Week Views

fileprivate extension GCCalendarMonthView {
    
    fileprivate func addWeekViews() {
        
        for dates in self.dates {
            
            let weekView = GCCalendarWeekView(configuration: self.configuration)
            
            weekView.dates = dates
            
            self.addArrangedSubview(weekView)
            self.weekViews.append(weekView)
        }
    }
    
    fileprivate func updateWeekViews() {
        
        self.weekViews.enumerated().forEach { index, weekView in
            
            weekView.dates = self.dates[index]
        }
    }
}

// MARK: - Selected Date

internal extension GCCalendarMonthView {
    
    internal func setSelectedDate() {
        
        let selectedDate: Date = self.containsToday ? Date() : self.startDate
        
        let selectedDateComponents = self.configuration.calendar.dateComponents([.weekOfMonth, .weekday], from: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth! - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday!)
    }
}
