//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarMonthView: UIView {
    
    // MARK: Properties
    
    fileprivate let configuration: GCCalendarConfiguration
    
    fileprivate var weekViews = [GCCalendarWeekView]()
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
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
    
    internal var startDate: Date! {
        
        didSet {
            
            self.weekViews.isEmpty ? self.addWeekViews() : self.updateWeekViews()
        }
    }
    
    internal var containsToday: Bool {
        
        return self.configuration.calendar.isDate(self.startDate, equalTo: Date(), toGranularity: .month)
    }
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        self.configuration = configuration
        
        super.init(frame: CGRect.zero)
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
        
        var views = [String: UIView]()
        var verticalVisualFormat = "V:|"
        
        self.dates.enumerated().forEach { index, dates in
            
            let weekView = GCCalendarWeekView(configuration: self.configuration)
            
            weekView.dates = dates
            weekView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(weekView)
            self.weekViews.append(weekView)
            
            let currentWeekView = "weekView\(index)"
            let previousWeekView = "weekView\(index - 1)"
            
            views[currentWeekView] = weekView
            
            switch index {
                
                case 0:
                    verticalVisualFormat += "[\(currentWeekView)]"
                    
                default:
                    verticalVisualFormat += "[\(currentWeekView)(==\(previousWeekView))]"
            }
            
            let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(currentWeekView)]|", options: [], metrics: nil, views: views)
            
            self.addConstraints(horizontal)
        }
        
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat + "|", options: [], metrics: nil, views: views)
        
        self.addConstraints(vertical)
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
