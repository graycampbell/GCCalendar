//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/29/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarWeekView: UIView {
    
    // MARK: Properties
    
    fileprivate let configuration: GCCalendarConfiguration
    
    fileprivate var dayViews = [GCCalendarDayView]()
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var dates: [Date?] = [] {
        
        didSet {
            
            self.dayViews.isEmpty ? self.addDayViews() : self.updateDayViews()
        }
    }
    
    internal var containsToday: Bool {
        
        return self.dates.contains(where: { $0 != nil && self.configuration.calendar.isDateInToday($0!) })
    }
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        self.configuration = configuration
        
        super.init(frame: CGRect.zero)
    }
}

// MARK: - Day Views

fileprivate extension GCCalendarWeekView {
    
    fileprivate func addDayViews() {
        
        var previousViewAnchor: NSLayoutAnchor = self.leftAnchor
        
        self.dates.enumerated().forEach { index, date in
            
            let dayView = GCCalendarDayView(configuration: self.configuration)
            
            dayView.date = date
            dayView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(dayView)
            self.dayViews.append(dayView)
            
            dayView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            dayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            dayView.leftAnchor.constraint(equalTo: previousViewAnchor).isActive = true
            
            if index > 0 {
                
                dayView.widthAnchor.constraint(equalTo: self.dayViews[index - 1].widthAnchor).isActive = true
            }
            
            previousViewAnchor = dayView.rightAnchor
        }
        
        previousViewAnchor.constraint(equalTo: self.rightAnchor).isActive = true
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
