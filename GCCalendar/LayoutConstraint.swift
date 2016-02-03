//
//  LayoutConstraint.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

import UIKit

extension NSLayoutConstraint
{
    convenience init(i i1: AnyObject, a a1: NSLayoutAttribute, r: NSLayoutRelation = .Equal, i i2: AnyObject? = nil, var a a2: NSLayoutAttribute = .NotAnAttribute, m: CGFloat = 1, c: CGFloat = 0)
    {
        if i2 != nil && a2 == .NotAnAttribute
        {
            a2 = a1
        }
        else if i2 == nil && a2 != .NotAnAttribute
        {
            a2 = .NotAnAttribute
        }
        
        self.init(item: i1, attribute: a1, relatedBy: r, toItem: i2, attribute: a2, multiplier: m, constant: c)
    }
}
