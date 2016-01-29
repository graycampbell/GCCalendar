//
//  LayoutConstraint.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

public extension NSLayoutConstraint
{
    public convenience init(i i1: AnyObject, a a1: NSLayoutAttribute, r: NSLayoutRelation = .Equal, i i2: AnyObject? = nil, var a a2: NSLayoutAttribute? = nil, m: CGFloat = 1, c: CGFloat = 0)
    {
        a2 = (a2 == nil) ? a1 : a2
        
        self.init(item: i1, attribute: a1, relatedBy: r, toItem: i2, attribute: a2!, multiplier: m, constant: c)
    }
}
