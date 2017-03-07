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
    
    fileprivate var dayViews = [GCCalendarDayView]()
    
    internal let panGestureRecognizer = UIPanGestureRecognizer()
    
    internal var containsToday: Bool {
        
        return !self.dates.filter({ $0 != nil && self.configuration.calendar.isDateInToday($0!) }).isEmpty
    }
    
    internal var dates: [Date?] = [] {
        
        didSet {
            
            self.dayViews.isEmpty ? self.addDayViews() : self.updateDayViews()
        }
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
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Day Views

fileprivate extension GCCalendarWeekView {
    
    fileprivate func addDayViews() {
        
        self.dates.forEach { date in
            
            let dayView = GCCalendarDayView(configuration: self.configuration)
            
            dayView.date = date
            
            self.addArrangedSubview(dayView)
            self.dayViews.append(dayView)
        }
    }
    
    fileprivate func updateDayViews() {
        
        var index = 0
        
        self.dayViews.forEach { dayView in
            
            dayView.date = self.dates[index]
            
            index += 1
        }
    }
}

// MARK: - Selected Date

internal extension GCCalendarWeekView {
    
    // MARK: Selected Date
    
    internal func setSelectedDate(weekday: Int) {
        
        self.dayViews[weekday - 1].highlight()
    }
}
