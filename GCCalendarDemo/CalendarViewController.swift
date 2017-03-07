//
//  CalendarViewController.swift
//  GCCalendarDemo
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit
import GCCalendar

// MARK: Properties & Initializers

class CalendarViewController: UIViewController {
    
    // MARK: Properties
    
    fileprivate var calendarView: GCCalendarView!
}

// MARK: - View

extension CalendarViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        
        let tintColor = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        
        self.navigationController!.toolbar.tintColor = tintColor
        self.navigationController!.navigationBar.tintColor = tintColor
        
        self.addToolbar()
        self.addCalendarView()
        self.addConstraints()
    }
}

// MARK: - Toolbar

extension CalendarViewController {
    
    fileprivate func addToolbar() {
        
        self.navigationController!.isToolbarHidden = false
        
        let today = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(self.today))
        
        self.toolbarItems = [today]
    }
    
    func today() {
        
        self.calendarView.today()
    }
}

// MARK: - Calendar View

fileprivate extension CalendarViewController {
    
    fileprivate func addCalendarView() {
        
        self.calendarView = GCCalendarView(delegate: self, calendar: .current)
        
        self.calendarView.automaticallyUpdatesDisplayMode = true
        self.calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.calendarView)
    }
}

// MARK: - Constraints

fileprivate extension CalendarViewController {
    
    fileprivate func addConstraints() {
        
        let views: [String: UIView] = ["calendarView": self.calendarView]
        
        let top = self.calendarView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 12)
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:[calendarView(325)]", options: [], metrics: nil, views: views)
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[calendarView]|", options: [], metrics: nil, views: views)
        
        self.view.addConstraint(top)
        self.view.addConstraints(vertical)
        self.view.addConstraints(horizontal)
    }
}

// MARK: - GCCalendarViewDelegate

extension CalendarViewController: GCCalendarViewDelegate {
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMYYYY", options: 0, locale: .current)
        
        self.navigationItem.title = dateFormatter.string(from: date)
    }
}
