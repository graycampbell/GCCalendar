//
//  GCCalendar.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import Foundation

struct GCCalendar {
    static func weekdaySymbols(forCalendar calendar: Calendar) -> [String] {
        let firstWeekdayIndex = calendar.firstWeekday - 1
        let weekdaySymbols = calendar.veryShortWeekdaySymbols
        let reorderedWeekdaySymbols = weekdaySymbols[firstWeekdayIndex..<weekdaySymbols.count] + weekdaySymbols[0..<firstWeekdayIndex]
        
        return [String](reorderedWeekdaySymbols)
    }
    
    static func datesForMonth(withDate date: Date, inCalendar calendar: Calendar) -> [[Date?]] {
        let numberOfWeeks = calendar.maximumRange(of: .weekOfMonth)!.count
        let numberOfWeekdays = calendar.maximumRange(of: .weekday)!.count
        
        var newDates = [[Date?]](repeating: [Date?](repeating: nil, count: numberOfWeekdays), count: numberOfWeeks)
        
        var components = calendar.dateComponents([.day, .month, .year], from: Date())
        
        components.day = 1
        
        let startDate = calendar.date(from: components)!
        var date = startDate
        
        repeat {
            let weekday = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date)!
            var weekOfMonth = calendar.ordinality(of: .weekOfMonth, in: .month, for: date)!
            
            if calendar.ordinality(of: .weekOfMonth, in: .month, for: startDate)! != 0 {
                weekOfMonth -= 1
            }
            
            newDates[weekOfMonth][weekday - 1] = date
            
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        } while calendar.isDate(date, equalTo: startDate, toGranularity: .month)
        
        return newDates
    }
    
    static func string(fromDate date: Date?, withFormat format: String, inCalendar calendar: Calendar) -> String {
        guard let date = date else { return "" }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "d", options: 0, locale: calendar.locale)
        
        return dateFormatter.string(from: date)
    }
    
    static func isDate(_ date1: Date?, inSameDayAs date2: Date, inCalendar calendar: Calendar) -> Bool {
        guard let date1 = date1 else { return false }
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
