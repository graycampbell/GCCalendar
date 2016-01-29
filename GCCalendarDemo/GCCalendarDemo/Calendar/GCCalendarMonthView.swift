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
    
    var topConstraint, bottomConstraint, leftConstraint, rightConstraint, widthConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init()
    {
        super.init(frame: CGRectZero)
        
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
        let numberOfWeeks = 6
        let heightMultiplier = 1.0 / CGFloat(numberOfWeeks)
        
        for var i = 0; i < numberOfWeeks; i++
        {
            let weekView = GCCalendarWeekView()
            
            self.addSubview(weekView)
            self.weekViews.append(weekView)
            
            weekView.addDayViews()
            
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
