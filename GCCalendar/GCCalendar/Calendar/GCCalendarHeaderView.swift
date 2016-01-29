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
    // MARK: - Properties
    
    private let calendar: NSCalendar!
    private var weekdayLabels: [GCCalendarWeekdayLabel] = []
    
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
        
        self.addWeekdayLabels()
    }
}

// MARK: - Weekday Labels

extension GCCalendarHeaderView
{
    // MARK: Creation
    
    private func addWeekdayLabels()
    {
        let numberOfDays = self.calendar.veryShortWeekdaySymbols.count
        let widthMultiplier = 1.0 / CGFloat(numberOfDays)
        
        for var i = 0; i < numberOfDays; i++
        {
            let label = GCCalendarWeekdayLabel(text: self.calendar.veryShortWeekdaySymbols[i])
            
            self.addSubview(label)
            self.weekdayLabels.append(label)
            
            if i == 0
            {
                self.addConstraintsForWeekdayLabel(label, item: self, attribute: .Left, widthMultiplier: widthMultiplier)
            }
            else
            {
                self.addConstraintsForWeekdayLabel(label, item: self.weekdayLabels[i - 1], attribute: .Right, widthMultiplier: widthMultiplier)
            }
        }
    }
    
    // MARK: Constraints
    
    private func addConstraintsForWeekdayLabel(weekdayLabel: GCCalendarWeekdayLabel, item: AnyObject, attribute: NSLayoutAttribute, widthMultiplier: CGFloat)
    {
        let left = NSLayoutConstraint(i: self, a: .Left, i: item, a: attribute)
        let width = NSLayoutConstraint(i: self, a: .Width, i: self, m: widthMultiplier)
        let height = NSLayoutConstraint(i: self, a: .Height, i: self)
        
        self.addConstraints([left, width, height])
    }
}
