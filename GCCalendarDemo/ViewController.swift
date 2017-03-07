//
//  ViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit
import GCCalendar

class ViewController: UIViewController, GCCalendarViewDelegate {
    
    // MARK: - Properties
    
    private var calendarView: GCCalendarView!
    
    // MARK: - View Setup
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        
        let tintColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        
        self.navigationController!.toolbar.tintColor = tintColor
        self.navigationController!.navigationBar.tintColor = tintColor
        
        self.addToolbar()
        self.addCalendarView()
    }
    
    // MARK: - Toolbar
    
    fileprivate func addToolbar() {
        
        self.navigationController!.isToolbarHidden = false
        
        let today = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.today))
        
        self.toolbarItems = [today]
    }
    
    func today() {
        
        self.calendarView.today()
    }
    
    // MARK: - Calendar View
    
    fileprivate func addCalendarView() {
        
        self.calendarView = GCCalendarView(delegate: self, calendar: Calendar.current)
        
        self.calendarView.automaticallyUpdatesDisplayMode = true
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.calendarView)
        self.addCalendarViewConstraints()
    }
    
    fileprivate func addCalendarViewConstraints() {
        
        let top = NSLayoutConstraint(item: self.calendarView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 12)
        let width = NSLayoutConstraint(item: self.calendarView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: self.calendarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 325)
        
        self.view.addConstraints([top, width, height])
    }
    
    // MARK: - GCCalendarViewDelegate
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMYYYY", options: 0, locale: Locale.current)
        
        self.navigationItem.title = dateFormatter.string(from: date)
    }
}
