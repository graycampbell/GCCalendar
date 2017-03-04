//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit
import GCCalendar

class ViewController: GCCalendarViewController {
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tintColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        
        self.navigationController!.toolbar.tintColor = tintColor
        self.navigationController!.navigationBar.tintColor = tintColor
        
        self.navigationController!.navigationBar.shadowImage = UIImage(named: "NavigationBarShadowImage")
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(named: "NavigationBarBackgroundImage"), for: .default)
        
        self.addToolbar()
        self.addCalendarViewConstraints()
    }
    
    // MARK: - Toolbar
    
    fileprivate func addToolbar() {
        
        self.navigationController!.isToolbarHidden = false
        
        let today = UIBarButtonItem(title: "Today", style: .plain, target: self.calendarView, action: #selector(self.calendarView.today))
        
        self.toolbarItems = [today]
        
        let shadowImage = UIImage(named: "ToolbarShadowImage")
        let backgroundImage = UIImage(named: "NavigationBarBackgroundImage")
        
        self.navigationController!.toolbar.setShadowImage(shadowImage, forToolbarPosition: .bottom)
        self.navigationController!.toolbar.setBackgroundImage(backgroundImage, forToolbarPosition: .bottom, barMetrics: .default)
    }
    
    // MARK: - Calendar View
    
    fileprivate func addCalendarViewConstraints() {
        
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 12)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - Override Functions
    
    override func shouldAutomaticallyChangeModeOnOrientationChange() -> Bool {
        
        return true
    }
    
    override func didSelectDate(_ date: Date) {
        
        super.didSelectDate(date)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMYYYY", options: 0, locale: Locale.current)
        
        self.navigationItem.title = dateFormatter.string(from: date)
    }
}
