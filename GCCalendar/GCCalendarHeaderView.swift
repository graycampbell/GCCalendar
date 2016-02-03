//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

public final class GCCalendarHeaderView: UIStackView
{
    // MARK: - Properties
    
    var weekdayLabels: [GCCalendarWeekdayLabel] = []
    
    // MARK: - Initializers
    
    public convenience init()
    {
        self.init(frame: CGRectZero)
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
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
        for var i = 0; i < Calendar.currentCalendar.veryShortWeekdaySymbols.count; i++
        {
            let label = GCCalendarWeekdayLabel(text: Calendar.currentCalendar.veryShortWeekdaySymbols[i])
            
            self.addArrangedSubview(label)
            self.weekdayLabels.append(label)
        }
    }
}
