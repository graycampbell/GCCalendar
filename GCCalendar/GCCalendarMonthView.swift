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
    
    fileprivate var weekViews: [GCCalendarWeekView] = []
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return self.configuration.calendar.isDate(self.startDate, equalTo: Date(), toGranularity: .month)
    }
    
    fileprivate var dates: [[Date?]] {
        
        var date: Date? = self.startDate
        
        let numberOfWeekdays = (self.configuration.calendar as NSCalendar).maximumRange(of: .weekday).length
        let numberOfWeeks = (self.configuration.calendar as NSCalendar).maximumRange(of: .weekOfMonth).length
        
        let week = [Date?](repeating: nil, count: numberOfWeekdays)
        
        var newDates = [[Date?]](repeating: week, count: numberOfWeeks)
        
        while date != nil {
            
            let dateComponents = self.configuration.calendar.dateComponents([.weekday, .weekOfMonth, .month, .year], from: date!)
            
            newDates[dateComponents.weekOfMonth! - 1][dateComponents.weekday! - 1] = date
            
            if let newDate = (self.configuration.calendar as NSCalendar).date(byAdding: .day, value: 1, to: date!, options: .matchStrictly) {
                
                let newDateComponents = self.configuration.calendar.dateComponents([.month], from: newDate)
                
                date = (newDateComponents.month == dateComponents.month) ? newDate : nil
            }
        }
        
        return newDates
    }
    
    var startDate: Date! {
        
        didSet {
            
            if self.weekViews.isEmpty {
                
                for dates in self.dates {
                    
                    let weekView = GCCalendarWeekView(configuration: self.configuration)
                    
                    weekView.dates = dates
                    
                    self.addArrangedSubview(weekView)
                    self.weekViews.append(weekView)
                }
            }
            else {
                
                for (index, dates) in self.dates.enumerated() {
                    
                    self.weekViews[index].dates = dates
                }
            }
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
        
        self.translatesAutoresizingMaskIntoConstraints = false
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

// MARK: - Selected Date

internal extension GCCalendarMonthView {
    
    // MARK: Selected Date
    
    internal func setSelectedDate() {
        
        let selectedDate: Date = self.containsToday ? Date() : self.startDate
        
        let selectedDateComponents = self.configuration.calendar.dateComponents([.weekOfMonth, .weekday], from: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth! - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday!)
    }
}
