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
    
    internal let panGestureRecognizer = UIPanGestureRecognizer()
    
    internal var containsToday: Bool {
        
        return self.dates.contains(where: { $0 != nil && self.configuration.calendar.isDateInToday($0!) })
    }
    
    internal var dates: [Date?] = [] {
        
        didSet {
            
            self.dayViews.isEmpty ? self.addDayViews() : self.updateDayViews()
        }
    }
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    internal init(configuration: GCCalendarConfiguration) {
        
        self.configuration = configuration
        
        super.init(frame: CGRect.zero)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - Day Views

fileprivate extension GCCalendarWeekView {
    
    fileprivate func addDayViews() {
        
        var views = [String: UIView]()
        var horizontalVisualFormat = "H:|"
        
        self.dates.enumerated().forEach { index, date in
            
            let dayView = GCCalendarDayView(configuration: self.configuration)
            
            dayView.date = date
            dayView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(dayView)
            self.dayViews.append(dayView)
            
            let currentDayView = "dayView\(index)"
            let previousDayView = "dayView\(index - 1)"
            
            views[currentDayView] = dayView
            
            switch index {
                
                case 0:
                    horizontalVisualFormat += "[\(currentDayView)]"
                    
                default:
                    horizontalVisualFormat += "[\(currentDayView)(==\(previousDayView))]"
            }
            
            let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(currentDayView)]|", options: [], metrics: nil, views: views)
            
            self.addConstraints(vertical)
        }
        
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat + "|", options: [], metrics: nil, views: views)
        
        self.addConstraints(horizontal)
    }
    
    fileprivate func updateDayViews() {
        
        self.dayViews.enumerated().forEach { index, dayView in
            
            dayView.date = self.dates[index]
        }
    }
}

// MARK: - Selected Date

internal extension GCCalendarWeekView {
    
    internal func setSelectedDate(weekday: Int) {
        
        self.dayViews[weekday - 1].highlight()
    }
}
