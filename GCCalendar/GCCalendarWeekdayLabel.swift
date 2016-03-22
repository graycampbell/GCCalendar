//
//  GCCalendarWeekdayLabel.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

internal final class GCCalendarWeekdayLabel: UILabel
{
    // MARK: - Initializers
    
    internal convenience init(viewController: GCCalendarViewController, text: String)
    {
        self.init(frame: CGRectZero)
        
        self.text = text
        self.textAlignment = .Center
        
        self.font = viewController.weekdayLabelFont()
        self.textColor = viewController.weekdayLabelTextColor()
    }
}
