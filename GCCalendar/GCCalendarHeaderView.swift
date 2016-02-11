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
    
    private var viewController: GCCalendarViewController!
    
    // MARK: - Initializers
    
    convenience init(viewController: GCCalendarViewController)
    {
        self.init(frame: CGRectZero)
        
        self.viewController = viewController
        
        self.axis = .Horizontal
        self.distribution = .FillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekdayLabels()
    }
    
    // MARK: - Weekday Labels
    
    private func addWeekdayLabels()
    {
        for weekdaySymbol in self.viewController.currentCalendar.veryShortWeekdaySymbols
        {
            let label = GCCalendarWeekdayLabel(text: weekdaySymbol)
            
            label.font = self.viewController.weekdayLabelFont()
            label.textColor = self.viewController.weekdayLabelTextColor()
            
            self.addArrangedSubview(label)
        }
    }
}
