//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarMonthView: UIView
{
    // MARK: - Properties
    
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    private var weekViews: [GCCalendarWeekView] = []
    
    private var startDate: NSDate!
    
    var topConstraint, bottomConstraint, leftConstraint, rightConstraint, widthConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    public convenience init(startDate: NSDate)
    {
        self.init(frame: CGRectZero)
        
        self.startDate = startDate
        
        self.translatesAutoresizingMaskIntoConstraints = false
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
    func addWeekViews()
    {
        var date: NSDate? = self.startDate
        
        var dates: [[NSDate?]] = [[NSDate?]](count: 6, repeatedValue: [nil, nil, nil, nil, nil, nil, nil])
        
        while date != nil
        {
            let dateComponents = Calendar.currentCalendar.components([.WeekOfMonth, .Weekday, .Day], fromDate: date!)
            
            dates[dateComponents.weekOfMonth - 1][dateComponents.weekday - 1] = date
            
            date = Calendar.currentCalendar.dateBySettingUnit(.Day, value: dateComponents.day + 1, ofDate: date!, options: .MatchStrictly)
        }
        
        let heightMultiplier = 1.0 / CGFloat(dates.count)
        
        for var i = 0; i < dates.count; i++
        {
            let weekView = GCCalendarWeekView()
            
            self.addSubview(weekView)
            self.weekViews.append(weekView)
            
            weekView.addDayViews(dates[i])
            
            if i == 0
            {
                self.addConstraintsForWeekView(weekView, item: self, attribute: .Top, heightMultiplier: heightMultiplier)
            }
            else
            {
                self.addConstraintsForWeekView(weekView, item: self.weekViews[i - 1], attribute: .Bottom, heightMultiplier: heightMultiplier)
            }
        }
    }
    
    private func addConstraintsForWeekView(weekView: GCCalendarWeekView, item: AnyObject, attribute: NSLayoutAttribute, heightMultiplier: CGFloat)
    {
        let top = NSLayoutConstraint(i: weekView, a: .Top, i: item, a: attribute)
        let width = NSLayoutConstraint(i: weekView, a: .Width, i: self)
        let height = NSLayoutConstraint(i: weekView, a: .Height, i: self, m: heightMultiplier)
        
        self.addConstraints([top, width, height])
    }
}
