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
    
    internal var containsToday: Bool {
        
        return self.dates.contains(where: { $0 != nil && self.configuration.calendar.isDateInToday($0!) })
    }
    
    // MARK: Initializers
    
    required init(coder: NSCoder) {
        
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
    
    fileprivate func addDayViews() {
        
        self.dates.forEach { date in
            
            let dayView = GCCalendarDayView(configuration: self.configuration)
            
            dayView.date = date
            
            self.addArrangedSubview(dayView)
        }
    }
    
    fileprivate func updateDayViews() {
        
        self.dayViews.enumerated().forEach { index, dayView in
            
            dayView.date = self.dates[index]
        }
    }
}

// MARK: - Pan Gesture Recognizer

internal extension GCCalendarWeekView {
    
    internal func addPanGestureRecognizer(target: Any?, action: Selector?) {
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Selected Date

internal extension GCCalendarWeekView {
    
    internal func setSelectedDate(weekday: Int) {
        
        self.dayViews[weekday - 1].highlight()
    }
}
