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
    
    private let calendar: NSCalendar!
    private let panGestureRecognizer = UIPanGestureRecognizer()
    
    var leftConstraint, rightConstraint, widthConstraint, heightConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init(calendar: NSCalendar)
    {
        self.calendar = calendar
        
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addDateViews()
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

// MARK: - Date Views

extension GCCalendarMonthView
{
    private func addDateViews()
    {
        
    }
}
