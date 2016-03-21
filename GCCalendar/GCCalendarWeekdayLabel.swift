//
//  GCCalendarWeekdayLabel.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

final class GCCalendarWeekdayLabel: UILabel
{
    // MARK: - Initializers
    
    internal convenience init(text: String)
    {
        self.init(frame: CGRectZero)
        
        self.text = text
        self.textAlignment = .Center
    }
}
