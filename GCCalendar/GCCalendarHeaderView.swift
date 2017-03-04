//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarHeaderView: UIStackView {
    
    // MARK: Properties
    
    fileprivate var viewController: GCCalendarViewController!
    
    // MARK: Initializers
    
    required internal init(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    internal init(viewController: GCCalendarViewController) {
        
        super.init(frame: CGRect.zero)
        
        self.viewController = viewController
        
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addWeekdayLabels()
    }
}

// MARK: - Weekday Labels

private extension GCCalendarHeaderView {
    
    // MARK: Creation
    
    func addWeekdayLabels() {
        
        for weekdaySymbol in self.viewController.calendar.veryShortWeekdaySymbols {
            
            let label = GCCalendarWeekdayLabel(viewController: self.viewController, text: weekdaySymbol)
            
            self.addArrangedSubview(label)
        }
    }
}
