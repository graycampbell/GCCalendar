//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarHeaderView: UIStackView
{
    // MARK: Properties
    
    private let viewController: GCCalendarViewController!
    
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    internal init(viewController: GCCalendarViewController)
    {
        self.viewController = viewController
        
        super.init(frame: CGRectZero)
        
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
        for weekdaySymbol in self.viewController.calendar.veryShortWeekdaySymbols
        {
            let label = GCCalendarWeekdayLabel(viewController: self.viewController, text: weekdaySymbol)
            
            self.addArrangedSubview(label)
        }
    }
}
