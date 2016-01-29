//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//  Copyright © 2016 Gray Campbell. All rights reserved.
//

public final class GCCalendarView: UIView
{
    // MARK: - Properties
    
    private let calendar = NSCalendar.currentCalendar()
    
    private var monthViews: [GCCalendarMonthView] = []
    
    // MARK: - Initializers
    
    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("GCCalendar does not support NSCoding.")
    }
    
    public init()
    {
        super.init(frame: CGRectZero)
        
        self.addMonthViews()
    }
}

// MARK: - Month Views

extension GCCalendarView
{
    // MARK: Creation
    
    func addMonthViews()
    {
        let previousMonthView = self.getMonthView()
        let currentMonthView = self.getMonthView()
        let nextMonthView = self.getMonthView()
        
        self.monthViews = [previousMonthView, currentMonthView, nextMonthView]
        
        for monthView in self.monthViews
        {
            self.addSubview(monthView)
            monthView.addConstraints()
        }
        
        self.updateConstraintsForMonthViews()
    }
    
    func getMonthView() -> GCCalendarMonthView
    {
        let monthView = GCCalendarMonthView(calendar: self.calendar)
        monthView.addPanGestureRecognizer(self, action: "toggleCurrentMonth:")
        
        return monthView
    }
    
    // MARK: Constraints
    
    func updateConstraintsForMonthViews()
    {
        for monthView in self.monthViews
        {
            monthView.leftConstraint?.active = false
            monthView.rightConstraint?.active = false
        }
        
        self.updateConstraintsForPreviousMonthView()
    }
    
    func updateConstraintsForPreviousMonthView()
    {
        self.previousMonthView.rightConstraint = NSLayoutConstraint(i: self.previousMonthView, a: .Right, i: self.currentMonthView, a: .Left)
        
        self.addConstraint(self.previousMonthView.rightConstraint)
    }
    
    func updateConstraintsForNextMonthView()
    {
        self.nextMonthView.leftConstraint = NSLayoutConstraint(i: self.nextMonthView, a: .Left, i: self.currentMonthView, a: .Right)
        
        self.addConstraint(self.nextMonthView.leftConstraint)
    }
    
    // MARK: Properties
    
    var previousMonthView: GCCalendarMonthView {
        
        return self.monthViews[0]
    }
    
    var currentMonthView: GCCalendarMonthView {
        
        return self.monthViews[1]
    }
    
    var nextMonthView: GCCalendarMonthView {
        
        return self.monthViews[2]
    }
}
