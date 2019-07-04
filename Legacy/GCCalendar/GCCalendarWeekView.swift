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
    
    fileprivate var configuration: GCCalendarConfiguration!
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    fileprivate var dayViews: [GCCalendarDayView] {
        
        return self.arrangedSubviews as! [GCCalendarDayView]
    }
    
    internal var dates: [Date?] = [] {
        
        didSet {
            
            self.dayViews.isEmpty ? self.addDayViews() : self.updateDayViews()
        }
    }
    
    internal func contains(date: Date) -> Bool {
        
        return self.dates.contains(where: { possibleDate in
            
            guard let unwrappedDate = possibleDate else { return false }
            
            return self.configuration.calendar.isDate(unwrappedDate, equalTo: date, toGranularity: .weekOfYear)
        })
    }
    
    // MARK: Initializers
    
    required internal init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        super.init(frame: CGRect.zero)
        
        self.configuration = configuration
        
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
}

// MARK: - Day Views

fileprivate extension GCCalendarWeekView {
    
    func addDayViews() {
        
        for date in self.dates {
            
            let dayView = GCCalendarDayView(configuration: self.configuration)
            
            dayView.date = date
            
            self.addArrangedSubview(dayView)
        }
    }
    
    func updateDayViews() {
        
        for (index, date) in self.dates.enumerated() {
            
            self.dayViews[index].date = date
        }
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarWeekView {
    
    func addPanGestureRecognizer(target: Any?, action: Selector?) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Selected Date

internal extension GCCalendarWeekView {
    
    func select(date: Date? = nil) {
        
        if let newDate = date {
            
            for dayView in self.dayViews {
                
                guard let dayViewDate = dayView.date else { continue }
                
                if self.configuration.calendar.isDate(dayViewDate, inSameDayAs: newDate) {
                    
                    dayView.highlight()
                    
                    break
                }
            }
        }
        else {
            
            let selectedDateComponents = self.configuration.calendar.dateComponents([.weekday], from: self.configuration.selectedDate())
            
            for dayView in self.dayViews {
                
                guard let dayViewDate = dayView.date else { continue }
                
                let dayViewDateComponents = self.configuration.calendar.dateComponents([.weekday], from: dayViewDate)
                
                guard let dayViewDateWeekday = dayViewDateComponents.weekday else { continue }
                guard let selectedDateWeekday = selectedDateComponents.weekday else { continue }
                
                if dayViewDateWeekday == selectedDateWeekday {
                    
                    dayView.highlight()
                    
                    break
                }
            }
        }
    }
}
