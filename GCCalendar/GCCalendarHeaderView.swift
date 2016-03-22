//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

internal final class GCCalendarHeaderView: UIStackView
{
    // MARK: - Properties
    
    private weak var viewController: GCCalendarViewController!
    
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController)
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
        for weekdaySymbol in self.viewController.calendar.veryShortWeekdaySymbols
        {
            let label = GCCalendarWeekdayLabel(viewController: self.viewController, text: weekdaySymbol)
            
            self.addArrangedSubview(label)
        }
    }
}
