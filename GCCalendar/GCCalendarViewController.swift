//
//  GCCalendarViewController.swift
//  GCCalendar
//
//  Created by Gray Campbell on 2/10/16.
//

import UIKit

open class GCCalendarViewController: UIViewController {
    
    // MARK: Properties
    
    open var calendarView: GCCalendarView!
    open var selectedDate: Date = Date()
    
    internal var selectedDayView: GCCalendarDayView?
    internal let calendar = Calendar.current
    
    // MARK: View
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        
        if self.shouldAutomaticallyChangeModeOnOrientationChange() {
            
            switch UIApplication.shared.statusBarOrientation {
                
                case .portrait, .portraitUpsideDown:
                    self.calendarView = GCCalendarView(viewController: self, mode: .month)
                    
                default:
                    self.calendarView = GCCalendarView(viewController: self, mode: .week)
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        }
        else {
            
            self.calendarView = GCCalendarView(viewController: self, mode: .month)
        }
        
        self.view.addSubview(self.calendarView)
    }
    
    // MARK: Calendar Mode
    
    /// Default value is false. If returning true, portrait mode = .Month and landscape mode = .Week
    open func shouldAutomaticallyChangeModeOnOrientationChange() -> Bool {
        
        return false
    }
    
    // MARK: Selected Date
    
    /// Must call super.didSelectDate(date) before custom implementation
    open func didSelectDate(_ date: Date) {
        
        self.selectedDate = date
    }
    
    // MARK: Weekday Label
    
    /// Default value is UIFont.systemFontOfSize(10)
    open func weekdayLabelFont() -> UIFont {
        
        return UIFont.systemFont(ofSize: 10)
    }
    
    /// Default value is UIColor.grayColor()
    open func weekdayLabelTextColor() -> UIColor {
        
        return UIColor.gray
    }
    
    // MARK: Past Day View
    
    /// Default value is true
    open func pastDaysEnabled() -> Bool {
        
        return true
    }
    
    /// Default value is UIFont.systemFontOfSize(17)
    open func pastDayViewFont() -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    open func pastDayViewEnabledTextColor() -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    /// Default value is UIColor.grayColor()
    open func pastDayViewDisabledTextColor() -> UIColor {
        
        return UIColor.gray
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    open func pastDayViewSelectedFont() -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    /// Default value is UIColor.whiteColor()
    open func pastDayViewSelectedTextColor() -> UIColor {
        
        return UIColor.white
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    open func pastDayViewSelectedBackgroundColor() -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    // MARK: Current Day View
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    open func currentDayViewFont() -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    open func currentDayViewTextColor() -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    open func currentDayViewSelectedFont() -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    /// Default value is UIColor.whiteColor()
    open func currentDayViewSelectedTextColor() -> UIColor {
        
        return UIColor.white
    }
    
    /// Default value is UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    open func currentDayViewSelectedBackgroundColor() -> UIColor {
        
        return UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
    }
    
    // MARK: Future Day View
    
    /// Default value is UIFont.systemFontOfSize(17)
    open func futureDayViewFont() -> UIFont {
        
        return UIFont.systemFont(ofSize: 17)
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    open func futureDayViewTextColor() -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
    
    /// Default value is UIFont.boldSystemFontOfSize(17)
    open func futureDayViewSelectedFont() -> UIFont {
        
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    /// Default value is UIColor.whiteColor()
    open func futureDayViewSelectedTextColor() -> UIColor {
        
        return UIColor.white
    }
    
    /// Default value is UIColor(white: 0.0, alpha: 0.87)
    open func futureDayViewSelectedBackgroundColor() -> UIColor {
        
        return UIColor(white: 0.0, alpha: 0.87)
    }
}

// MARK: - Orientation

internal extension GCCalendarViewController {
    
    internal func orientationChanged() {
        
        switch UIApplication.shared.statusBarOrientation {
            
            case .portrait, .portraitUpsideDown:
                self.calendarView.changeModeTo(.month)
                
            default:
                self.calendarView.changeModeTo(.week)
        }
    }
}

// MARK: - Day View Selection

internal extension GCCalendarViewController {
    
    internal func didSelectDayView(_ dayView: GCCalendarDayView) {
        
        self.selectedDayView = dayView
        
        self.didSelectDate(dayView.date! as Date)
    }
}
