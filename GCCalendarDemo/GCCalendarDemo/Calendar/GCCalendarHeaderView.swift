//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarHeaderView: UIView
{
    // MARK: - Initializers
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init()
    {
        super.init(frame: CGRectZero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekdayLabels()
    }
}

// MARK: - Weekday Labels

extension GCCalendarHeaderView
{
    // MARK: Creation
    
    private func addWeekdayLabels()
    {
        let numberOfDays = Calendar.currentCalendar.veryShortWeekdaySymbols.count
        let widthMultiplier = 1.0 / CGFloat(numberOfDays)
        
        for var i = 0; i < numberOfDays; i++
        {
            let label = GCCalendarWeekdayLabel(text: Calendar.currentCalendar.veryShortWeekdaySymbols[i])
            
            self.addSubview(label)
            Calendar.Header.weekdayLabels.append(label)
            
            if i == 0
            {
                self.addConstraintsForWeekdayLabel(label, item: self, attribute: .Left, widthMultiplier: widthMultiplier)
            }
            else
            {
                self.addConstraintsForWeekdayLabel(label, item: Calendar.Header.weekdayLabels[i - 1], attribute: .Right, widthMultiplier: widthMultiplier)
            }
        }
    }
    
    // MARK: Constraints
    
    private func addConstraintsForWeekdayLabel(weekdayLabel: GCCalendarWeekdayLabel, item: AnyObject, attribute: NSLayoutAttribute, widthMultiplier: CGFloat)
    {
        let top = NSLayoutConstraint(i: weekdayLabel, a: .Top, i: self)
        let left = NSLayoutConstraint(i: weekdayLabel, a: .Left, i: item, a: attribute)
        let width = NSLayoutConstraint(i: weekdayLabel, a: .Width, i: self, m: widthMultiplier)
        let height = NSLayoutConstraint(i: weekdayLabel, a: .Height, i: self)
        
        self.addConstraints([top, left, width, height])
    }
}
