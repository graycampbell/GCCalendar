//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

public enum GCCalendarDisplayMode {
    
    case week, month
}

// MARK: Properties & Initializers

public final class GCCalendarView: UIView {
    
    // MARK: Properties
    
    fileprivate let delegate: GCCalendarViewDelegate
    
    fileprivate var selectedDate = Date()
    fileprivate var selectedDayView: GCCalendarDayView? = nil
    
    fileprivate var configuration: GCCalendarConfiguration!
    
    fileprivate var headerView = UIStackView()
    fileprivate var weekViews: [GCCalendarWeekView] = []
    fileprivate var monthViews: [GCCalendarMonthView] = []
    
    fileprivate var panGestureStartLocation: CGFloat!
    
    public var displayMode: GCCalendarDisplayMode! {
        
        didSet {
            
            if self.displayMode != oldValue {
                
                switch self.displayMode! {
                    
                    case .week:
                        self.removeMonthViews()
                        self.addWeekViews()
                        
                    case .month:
                        self.removeWeekViews()
                        self.addMonthViews()
                }
            }
        }
    }
    
    public var automaticallyUpdatesDisplayMode: Bool = false {
        
        didSet {
            
            if self.automaticallyUpdatesDisplayMode != oldValue {
                
                if self.automaticallyUpdatesDisplayMode {
                    
                    self.updateDisplayMode()
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(self.updateDisplayMode), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
                }
                else {
                    
                    NotificationCenter.default.removeObserver(self, name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
                }
            }
        }
    }
    
    // MARK: Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        
        return nil
    }
    
    public init(delegate: GCCalendarViewDelegate, calendar: Calendar) {
        
        self.delegate = delegate
        
        super.init(frame: CGRect.zero)
        
        self.setConfiguration(calendar: calendar)
        
        self.addHeaderView()
    }
}

// MARK: - Layout

public extension GCCalendarView {
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.resetLayout()
    }
    
    fileprivate func resetLayout() {
        
        self.previousView.center.x = -self.bounds.size.width * 0.5
        self.currentView.center.x = self.bounds.size.width * 0.5
        self.nextView.center.x = self.bounds.size.width * 1.5
    }
}

// MARK: - Configuration

public extension GCCalendarView {
    
    fileprivate func setConfiguration(calendar: Calendar) {
        
        self.configuration = GCCalendarConfiguration()
        
        self.configuration.calendar = calendar
        
        self.configuration.appearance.weekdayLabelFont = self.delegate.weekdayLabelFont(forCalendarView: self)
        self.configuration.appearance.weekdayLabelTextColor = self.delegate.weekdayLabelTextColor(forCalendarView: self)
        
        self.configuration.appearance.pastDaysEnabled = self.delegate.pastDaysEnabled(forCalendarView: self)
        self.configuration.appearance.pastDayViewFont = self.delegate.pastDayViewFont(forCalendarView: self)
        self.configuration.appearance.pastDayViewEnabledTextColor = self.delegate.pastDayViewEnabledTextColor(forCalendarView: self)
        self.configuration.appearance.pastDayViewDisabledTextColor = self.delegate.pastDayViewDisabledTextColor(forCalendarView: self)
        self.configuration.appearance.pastDayViewSelectedFont = self.delegate.pastDayViewSelectedFont(forCalendarView: self)
        self.configuration.appearance.pastDayViewSelectedTextColor = self.delegate.pastDayViewSelectedTextColor(forCalendarView: self)
        self.configuration.appearance.pastDayViewSelectedBackgroundColor = self.delegate.pastDayViewSelectedBackgroundColor(forCalendarView: self)
        
        self.configuration.appearance.currentDayViewFont = self.delegate.currentDayViewFont(forCalendarView: self)
        self.configuration.appearance.currentDayViewTextColor = self.delegate.currentDayViewTextColor(forCalendarView: self)
        self.configuration.appearance.currentDayViewSelectedFont = self.delegate.currentDayViewSelectedFont(forCalendarView: self)
        self.configuration.appearance.currentDayViewSelectedTextColor = self.delegate.currentDayViewSelectedTextColor(forCalendarView: self)
        self.configuration.appearance.currentDayViewSelectedBackgroundColor = self.delegate.currentDayViewSelectedBackgroundColor(forCalendarView: self)
        
        self.configuration.appearance.futureDayViewFont = self.delegate.futureDayViewFont(forCalendarView: self)
        self.configuration.appearance.futureDayViewTextColor = self.delegate.futureDayViewTextColor(forCalendarView: self)
        self.configuration.appearance.futureDayViewSelectedFont = self.delegate.futureDayViewSelectedFont(forCalendarView: self)
        self.configuration.appearance.futureDayViewSelectedTextColor = self.delegate.futureDayViewSelectedTextColor(forCalendarView: self)
        self.configuration.appearance.futureDayViewSelectedBackgroundColor = self.delegate.futureDayViewSelectedBackgroundColor(forCalendarView: self)
        
        self.configuration.selectedDate = {
            
            return self.selectedDate
        }
        
        self.configuration.dayViewSelected = { dayView in
            
            self.selectedDayView?.unhighlight()
            
            self.selectedDate = dayView.date!
            self.selectedDayView = dayView
            
            self.delegate.calendarView(self, didSelectDate: self.selectedDate)
        }
    }
}

// MARK: - Display Mode

internal extension GCCalendarView {
    
    internal func updateDisplayMode() {
        
        switch UIApplication.shared.statusBarOrientation {
            
            case .landscapeLeft, .landscapeRight:
                self.displayMode = .week
                
            default:
                self.displayMode = .month
        }
    }
}

// MARK: - Header View

private extension GCCalendarView {
    
    func addHeaderView() {
        
        self.headerView.axis = .horizontal
        self.headerView.distribution = .fillEqually
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.configuration.calendar.veryShortWeekdaySymbols.forEach { weekdaySymbol in
            
            let label = UILabel()
            
            label.text = weekdaySymbol
            label.textAlignment = .center
            
            label.font = self.configuration.appearance.weekdayLabelFont
            label.textColor = self.configuration.appearance.weekdayLabelTextColor
            
            self.headerView.addArrangedSubview(label)
        }
        
        self.addSubview(self.headerView)
        self.addHeaderViewConstraints()
    }
    
    // MARK: Constraints
    
    func addHeaderViewConstraints() {
        
        let top = NSLayoutConstraint(item: self.headerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.headerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 15)
        
        self.addConstraints([top, width, height])
    }
}

// MARK: - Month & Week Views

public extension GCCalendarView {
    
    // MARK: Views
    
    fileprivate var previousView: UIView {
        
        switch self.displayMode! {
            
            case .week:
                return self.previousWeekView
            
            case .month:
                return self.previousMonthView
        }
    }
    
    fileprivate var currentView: UIView {
        
        switch self.displayMode! {
            
            case .week:
                return self.currentWeekView
                
            case .month:
                return self.currentMonthView
        }
    }
    
    fileprivate var nextView: UIView {
        
        switch self.displayMode! {
            
            case .week:
                return self.nextWeekView
                
            case .month:
                return self.nextMonthView
        }
    }
    
    // MARK: Today
    
    public func today() {
        
        switch self.displayMode! {
            
            case .week:
                self.findTodayInWeekViews()
                
            case .month:
                self.findTodayInMonthViews()
        }
    }
    
    fileprivate func findTodayInMonthViews() {
        
        if self.previousMonthView.containsToday {
            
            UIView.animate(withDuration: 0.15, animations: self.showPreviousView, completion: self.previousMonthViewDidShow)
        }
        else if self.currentMonthView.containsToday {
            
            self.currentMonthView.setSelectedDate()
        }
        else if self.nextMonthView.containsToday {
            
            UIView.animate(withDuration: 0.15, animations: self.showNextView, completion: self.nextMonthViewDidShow)
        }
        else {
            
            let today = Date()
            
            if today.compare(self.selectedDate) == .orderedAscending {
                
                self.showToday(today, animations: self.showPreviousView, monthViewReuse: self.reuseNextMonthView) { finished in
                 
                    if finished {
                        
                        self.previousMonthViewDidShow(finished)
                        
                        let newStartDate = self.nextMonthStartDate(currentMonthStartDate: self.currentMonthView.startDate)
                        
                        self.nextMonthView.startDate = newStartDate
                    }
                }
            }
            else if today.compare(self.selectedDate) == .orderedDescending {
                
                self.showToday(today, animations: self.showNextView, monthViewReuse: self.reusePreviousMonthView) { finished in
                    
                    if finished {
                        
                        self.nextMonthViewDidShow(finished)
                        
                        let newStartDate = self.previousMonthStartDate(currentMonthStartDate: self.currentMonthView.startDate)
                        
                        self.previousMonthView.startDate = newStartDate
                    }
                }
            }
        }
    }
    
    fileprivate func showToday(_ today: Date, animations: @escaping () -> Void, monthViewReuse: @escaping ((Date) -> Void), completion: @escaping ((Bool) -> Void)) {
        
        UIView.animate(withDuration: 0.08, animations: animations, completion: { finished in
            
            if finished {
                
                let newStartDate = self.currentMonthStartDate(fromDate: today)
                
                monthViewReuse(newStartDate)

                self.resetLayout()
                
                UIView.animate(withDuration: 0.08, animations: animations, completion: { finished in completion(finished) }) 
            }
        }) 
    }
    
    fileprivate func findTodayInWeekViews() {
        
        if self.previousWeekView.containsToday {
            
            UIView.animate(withDuration: 0.15, animations: self.showPreviousView, completion: self.previousWeekViewDidShow)
        }
        else if self.currentWeekView.containsToday {
            
            let todayComponents = self.configuration.calendar.dateComponents([.weekday, .weekOfYear], from: Date())
            
            self.currentWeekView.setSelectedDate(weekday: todayComponents.weekday!)
        }
        else if self.nextWeekView.containsToday {
            
            UIView.animate(withDuration: 0.15, animations: self.showNextView, completion: self.nextWeekViewDidShow)
        }
        else {
            
            let today = Date()
            
            if today.compare(self.selectedDate) == .orderedAscending {
                
                self.showToday(today, animations: self.showPreviousView, weekViewReuse: self.reuseNextWeekView) { finished in
                 
                    if finished {
                        
                        self.previousWeekViewDidShow(finished)
                        
                        let newDates = self.nextWeekDates(currentWeekDates: self.currentWeekView.dates)
                        
                        self.nextWeekView.dates = newDates
                    }
                }
            }
            else if today.compare(self.selectedDate) == .orderedDescending {
                
                self.showToday(today, animations: self.showNextView, weekViewReuse: self.reusePreviousWeekView) { finished in
                    
                    if finished {
                        
                        self.nextWeekViewDidShow(finished)
                        
                        let newDates = self.previousWeekDates(currentWeekDates: self.currentWeekView.dates)
                        
                        self.previousWeekView.dates = newDates
                    }
                }
            }
        }
    }
    
    fileprivate func showToday(_ today: Date, animations: @escaping () -> Void, weekViewReuse: @escaping (([Date?]) -> Void), completion: @escaping ((Bool) -> Void)) {
        
        UIView.animate(withDuration: 0.08, animations: animations, completion: { finished in
            
            if finished {
                
                let newDates = self.currentWeekDates(fromDate: today)
                
                weekViewReuse(newDates)
                
                self.resetLayout()
                
                UIView.animate(withDuration: 0.08, animations: animations, completion: { finished in completion(finished) }) 
            }
        }) 
    }
    
    // MARK: Toggle Current View
    
    internal func toggleCurrentView(_ pan: UIPanGestureRecognizer) {
        
        if pan.state == .began {
            
            self.panGestureStartLocation = pan.location(in: self).x
        }
        else if pan.state == .changed {
            
            let changeInX = pan.location(in: self).x - self.panGestureStartLocation
            
            if !(self.previousViewDisabled && self.currentView.center.x + changeInX > self.bounds.size.width * 0.5) {
                
                self.previousView.center.x += changeInX
                self.currentView.center.x += changeInX
                self.nextView.center.x += changeInX
            }
            
            self.panGestureStartLocation = pan.location(in: self).x
        }
        else if pan.state == .ended {
            
            if self.currentView.center.x < (self.bounds.size.width * 0.5) - 25 {
                
                UIView.animate(withDuration: 0.25, animations: self.showNextView, completion: self.nextViewDidShow)
            }
            else if self.currentView.center.x > (self.bounds.size.width * 0.5) + 25 {
                
                UIView.animate(withDuration: 0.25, animations: self.showPreviousView, completion: self.previousViewDidShow)
            }
            else {
                
                UIView.animate(withDuration: 0.15, animations: { self.resetLayout() }) 
            }
        }
    }
    
    fileprivate var previousViewDisabled: Bool {
        
        if !self.delegate.pastDaysEnabled(forCalendarView: self) {
            
            if self.previousView.isKind(of: GCCalendarMonthView.self) {
                
                return self.currentMonthView.containsToday
            }
            else {
                
                return self.currentWeekView.containsToday
            }
        }
        
        return false
    }
    
    // MARK: Show View
    
    fileprivate func showPreviousView() {
        
        self.previousView.center.x = self.bounds.size.width * 0.5
        self.currentView.center.x = self.bounds.size.width * 1.5
    }
    
    fileprivate func previousViewDidShow(_ finished: Bool) {
        
        if finished {
            
            switch self.displayMode! {
                
                case .week:
                    self.previousWeekViewDidShow(finished)
                    
                case .month:
                    self.previousMonthViewDidShow(finished)
            }
        }
    }
    
    fileprivate func showNextView() {
        
        self.currentView.center.x = -self.bounds.size.width * 0.5
        self.nextView.center.x = self.bounds.size.width * 0.5
    }
    
    fileprivate func nextViewDidShow(_ finished: Bool) {
        
        if finished {
            
            switch self.displayMode! {
                
                case .week:
                    self.nextWeekViewDidShow(finished)
                    
                case .month:
                    self.nextMonthViewDidShow(finished)
            }
        }
    }
}

// MARK: - Month Views

private extension GCCalendarView {
    
    // MARK: Views
    
    var previousMonthView: GCCalendarMonthView {
        
        return self.monthViews[0]
    }
    
    var currentMonthView: GCCalendarMonthView {
        
        return self.monthViews[1]
    }
    
    var nextMonthView: GCCalendarMonthView {
        
        return self.monthViews[2]
    }
    
    // MARK: Add Month Views
    
    func addMonthViews() {
        
        let currentMonthStartDate = self.currentMonthStartDate(fromDate: self.selectedDate)
        let previousMonthStartDate = self.previousMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        let nextMonthStartDate = self.nextMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        
        for startDate in [previousMonthStartDate, currentMonthStartDate, nextMonthStartDate] {
            
            let monthView = GCCalendarMonthView(configuration: self.configuration)
            
            monthView.startDate = startDate
            
            monthView.addPanGestureRecognizer(self, action: #selector(self.toggleCurrentView(_:)))
            
            self.addSubview(monthView)
            self.monthViews.append(monthView)
            
            let top = NSLayoutConstraint(item: monthView, attribute: .top, relatedBy: .equal, toItem: self.headerView, attribute: .bottom, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint(item: monthView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let width = NSLayoutConstraint(item: monthView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
            
            self.addConstraints([top, bottom, width])
        }
        
        self.resetLayout()
    }
    
    // MARK: Remove Month Views
    
    func removeMonthViews() {
        
        self.monthViews.forEach ({ $0.removeFromSuperview() })
        self.monthViews.removeAll()
    }
    
    // MARK: Start Dates
    
    func currentMonthStartDate(fromDate date: Date) -> Date {
        
        var components = self.configuration.calendar.dateComponents([.day, .month, .year], from: date)
        
        components.day = 1
        
        return self.configuration.calendar.date(from: components)!
    }
    
    func previousMonthStartDate(currentMonthStartDate: Date) -> Date {
        
        return (self.configuration.calendar as NSCalendar).date(byAdding: .month, value: -1, to: currentMonthStartDate, options: .matchStrictly)!
    }
    
    func nextMonthStartDate(currentMonthStartDate: Date) -> Date {
        
        return (self.configuration.calendar as NSCalendar).nextDate(after: currentMonthStartDate, matching: .day, value: 1, options: .matchStrictly)!
    }
    
    // MARK: Show Month View
    
    func previousMonthViewDidShow(_ finished: Bool) {
        
        if finished {
            
            let newStartDate = self.previousMonthStartDate(currentMonthStartDate: self.previousMonthView.startDate)
            
            self.reuseNextMonthView(newStartDate: newStartDate)
            
            self.monthViewDidShow()
        }
    }
    
    func reuseNextMonthView(newStartDate: Date) {
        
        self.nextMonthView.startDate = newStartDate
        self.monthViews.insert(self.nextMonthView, at: 0)
        self.monthViews.removeLast()
    }
    
    func nextMonthViewDidShow(_ finished: Bool) {
        
        if finished {
            
            let newStartDate = self.nextMonthStartDate(currentMonthStartDate: self.nextMonthView.startDate)
            
            self.reusePreviousMonthView(newStartDate: newStartDate)

            self.monthViewDidShow()
        }
    }
    
    func reusePreviousMonthView(newStartDate: Date) {
        
        self.previousMonthView.startDate = newStartDate
        self.monthViews.append(self.previousMonthView)
        self.monthViews.removeFirst()
    }
    
    func monthViewDidShow() {
        
        self.resetLayout()
        self.currentMonthView.setSelectedDate()
    }
}

// MARK: - Week Views

private extension GCCalendarView {
    
    // MARK: Views
    
    var previousWeekView: GCCalendarWeekView {
        
        return self.weekViews[0]
    }
    
    var currentWeekView: GCCalendarWeekView {
        
        return self.weekViews[1]
    }
    
    var nextWeekView: GCCalendarWeekView {
        
        return self.weekViews[2]
    }
    
    // MARK: Add Week Views
    
    func addWeekViews() {
        
        let currentWeekDates = self.currentWeekDates(fromDate: self.selectedDate)
        let previousWeekDates = self.previousWeekDates(currentWeekDates: currentWeekDates)
        let nextWeekDates = self.nextWeekDates(currentWeekDates: currentWeekDates)
        
        for dates in [previousWeekDates, currentWeekDates, nextWeekDates] {
            
            let weekView = GCCalendarWeekView(configuration: self.configuration)
            
            weekView.dates = dates
            weekView.panGestureRecognizer.addTarget(self, action: #selector(self.toggleCurrentView(_:)))
            
            self.addSubview(weekView)
            self.weekViews.append(weekView)
            
            let top = NSLayoutConstraint(item: weekView, attribute: .top, relatedBy: .equal, toItem: self.headerView, attribute: .bottom, multiplier: 1, constant: 0)
            let width = NSLayoutConstraint(item: weekView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
            let height = NSLayoutConstraint(item: weekView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 45)
            
            self.addConstraints([top, width, height])
        }
        
        self.resetLayout()
    }
    
    // MARK: Remove Week Views
    
    func removeWeekViews() {
        
        self.weekViews.forEach({ $0.removeFromSuperview() })
        self.weekViews.removeAll()
    }
    
    // MARK: Dates
    
    func previousWeekDates(currentWeekDates: [Date?]) -> [Date?] {
        
        let startDate = (self.configuration.calendar as NSCalendar).date(byAdding: .weekOfYear, value: -1, to: currentWeekDates.first!!, options: .matchStrictly)
        
        return self.weekDates(startDate: startDate)
    }
    
    func currentWeekDates(fromDate date: Date) -> [Date?] {
        
        var components = self.configuration.calendar.dateComponents([.weekday, .weekOfYear, .year], from: date)
        
        components.weekday = 1
        
        let startDate = self.configuration.calendar.date(from: components)
        
        return self.weekDates(startDate: startDate)
    }
    
    func nextWeekDates(currentWeekDates: [Date?]) -> [Date?] {
        
        let startDate = (self.configuration.calendar as NSCalendar).date(byAdding: .weekOfYear, value: 1, to: currentWeekDates.first!!, options: .matchStrictly)
        
        return self.weekDates(startDate: startDate)
    }
    
    func weekDates(startDate: Date?) -> [Date?] {
        
        var date: Date? = startDate
        
        let numberOfWeekdays = (self.configuration.calendar as NSCalendar).maximumRange(of: .weekday).length
        
        var dates = [Date?](repeating: nil, count: numberOfWeekdays)
        
        while date != nil {
            
            let dateComponents = self.configuration.calendar.dateComponents([.weekday, .weekOfYear, .year], from: date!)
            
            dates[dateComponents.weekday! - 1] = date
            
            if let newDate = (self.configuration.calendar as NSCalendar).date(byAdding: .weekday, value: 1, to: date!, options: .matchStrictly) {
                
                let newDateComponents = self.configuration.calendar.dateComponents([.weekOfYear], from: newDate)
                
                date = (newDateComponents.weekOfYear == dateComponents.weekOfYear) ? newDate : nil
            }
        }
        
        return dates
    }
    
    // MARK: Show Week View
    
    func previousWeekViewDidShow(_ finished: Bool) {
        
        if finished {
            
            let newDates = self.previousWeekDates(currentWeekDates: self.previousWeekView.dates)
            
            self.reuseNextWeekView(newDates: newDates)
            
            self.weekViewDidShow()
        }
    }
    
    func reuseNextWeekView(newDates: [Date?]) {
        
        self.nextWeekView.dates = newDates
        self.weekViews.insert(self.nextWeekView, at: 0)
        self.weekViews.removeLast()
    }
    
    func nextWeekViewDidShow(_ finished: Bool) {
        
        if finished {
            
            let newDates = self.nextWeekDates(currentWeekDates: self.nextWeekView.dates)
            
            self.reusePreviousWeekView(newDates: newDates)
            
            self.weekViewDidShow()
        }
    }
    
    func reusePreviousWeekView(newDates: [Date?]) {
        
        self.previousWeekView.dates = newDates
        self.weekViews.append(self.previousWeekView)
        self.weekViews.removeFirst()
    }
    
    func weekViewDidShow() {
        
        self.resetLayout()
        self.setSelectedWeekViewDate()
    }
    
    // MARK: Selected Week View Date
    
    func setSelectedWeekViewDate() {
        
        let todayComponents = self.configuration.calendar.dateComponents([.weekday, .weekOfYear], from: Date())
        
        if self.configuration.calendar.isDate(self.currentWeekView.dates.first!!, equalTo: Date(), toGranularity: .weekOfYear) {
            
            self.currentWeekView.setSelectedDate(weekday: todayComponents.weekday!)
        }
        else
        {
            let weekday = self.configuration.calendar.dateComponents([.weekday], from: self.selectedDate).weekday
            
            self.currentWeekView.setSelectedDate(weekday: weekday!)
        }
    }
}
