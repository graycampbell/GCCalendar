//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarMonthView: UIStackView
{
    // MARK: - Properties
    
    var originalCenter: CGPoint!
    
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    private var weekViews: [GCCalendarWeekView] = []
    
    var startDate: NSDate!
    
    var topConstraint, bottomConstraint, widthConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    public convenience init(startDate: NSDate)
    {
        self.init(frame: CGRectZero)
        
        self.startDate = startDate
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.axis = .Vertical
        self.distribution = .FillEqually
        
        self.addWeekViews()
    }
}

// MARK: - Pan Gesture Recognizer

extension GCCalendarMonthView
{
    func addPanGestureRecognizer(target: AnyObject, action: Selector)
    {
        self.panGestureRecognizer.addTarget(target, action: action)
        
        self.addGestureRecognizer(self.panGestureRecognizer)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension GCCalendarMonthView: UIGestureRecognizerDelegate
{
    public override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        let pan = gestureRecognizer as! UIPanGestureRecognizer
        
        return pan.velocityInView(pan.view!).x > pan.velocityInView(pan.view!).y
    }
}

// MARK: - Week Views

extension GCCalendarMonthView
{
    private func addWeekViews()
    {
        let dates = self.getDates()
        
        for var i = 0; i < dates.count; i++
        {
            let weekView = GCCalendarWeekView(dates: dates[i])
            
            self.addArrangedSubview(weekView)
            self.weekViews.append(weekView)
        }
    }
    
    private func getDates() -> [[NSDate?]]
    {
        var date: NSDate? = self.startDate
        
        var dates: [[NSDate?]] = [[NSDate?]](count: 6, repeatedValue: [nil, nil, nil, nil, nil, nil, nil])
        
        while date != nil
        {
            let dateComponents = Calendar.currentCalendar.components([.Month, .WeekOfMonth, .Weekday, .Day], fromDate: date!)
            
            dates[dateComponents.weekOfMonth - 1][dateComponents.weekday - 1] = date
            
            if let newDate = Calendar.currentCalendar.dateByAddingUnit(.Day, value: 1, toDate: date!, options: .MatchStrictly)
            {
                let newDateComponents = Calendar.currentCalendar.components(.Month, fromDate: newDate)
                
                date = (newDateComponents.month == dateComponents.month) ? newDate : nil
            }
        }
        
        return dates
    }
    
    func update(newStartDate newStartDate: NSDate)
    {
        self.startDate = newStartDate
        
        let dates = self.getDates()
        
        for var i = 0; i < self.weekViews.count; i++
        {
            self.weekViews[i].update(newDates: dates[i])
        }
    }
    
    func setSelectedDate()
    {
        let today = NSDate()
        
        let selectedDate = Calendar.currentCalendar.isDate(self.startDate, equalToDate: today, toUnitGranularity: .Month) ? today : self.startDate
        
        let selectedDateComponents = Calendar.currentCalendar.components([.WeekOfMonth, .Weekday], fromDate: selectedDate)
        
        let weekView = self.weekViews[selectedDateComponents.weekOfMonth - 1]
        
        weekView.setSelectedDate(weekday: selectedDateComponents.weekday)
    }
}
