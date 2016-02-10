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
    // MARK: - Initializers
    
    convenience init()
    {
        self.init(frame: CGRectZero)
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekdayLabels()
    }
    
    // MARK: - Weekday Labels
    
    private func addWeekdayLabels()
    {
        for weekdaySymbol in Calendar.currentCalendar.veryShortWeekdaySymbols
        {
            let label = GCCalendarWeekdayLabel(text: weekdaySymbol)
            
            self.addArrangedSubview(label)
        }
    }
}
