//
//  DateFormatter.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

extension NSDateFormatter
{
    convenience init(dateFormat: String)
    {
        self.init()
        
        self.dateFormat = dateFormat
    }
}
