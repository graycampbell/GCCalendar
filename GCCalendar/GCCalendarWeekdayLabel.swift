//
//  GCCalendarWeekdayLabel.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Properties & Initializers

internal final class GCCalendarWeekdayLabel: UILabel
{
    // MARK: Initializers
    
    required internal init?(coder aDecoder: NSCoder)
    {
        return nil
    }
    
    internal init(viewController: GCCalendarViewController, text: String)
    {
        super.init(frame: CGRectZero)
        
        self.text = text
        self.textAlignment = .Center
        
        self.font = viewController.weekdayLabelFont()
        self.textColor = viewController.weekdayLabelTextColor()
    }
}
