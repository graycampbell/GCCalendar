//
//  Color.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 100)
    {
        let red = r / 255
        let green = g / 255
        let blue = b / 255
        let alpha = a / 100
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
