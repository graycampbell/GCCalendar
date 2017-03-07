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
    
    var dates: [Date?] = [] {
        
        didSet {
            
            if self.dayViews.isEmpty {
                
                self.dates.forEach { date in
                    
                    let dayView = GCCalendarDayView(configuration: self.configuration)
                    
                    dayView.date = date
                    
                    self.addArrangedSubview(dayView)
                    self.dayViews.append(dayView)
                }
            }
            else {
                
                for (index, date) in self.dates.enumerated() {
                    
                    self.dayViews[index].date = date
                }
            }
        }
    }
    
    fileprivate var dayViews: [GCCalendarDayView] = []
    fileprivate var panGestureRecognizer: UIPanGestureRecognizer!
    
    internal var containsToday: Bool {
        
        return !self.dates.filter({ $0 != nil && self.configuration.calendar.isDateInToday($0!) }).isEmpty
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

// MARK: - Selected Date

internal extension GCCalendarWeekView {
    
    // MARK: Selected Date
    
    internal func setSelectedDate(weekday: Int) {
        
        self.dayViews[weekday - 1].highlight()
    }
}
