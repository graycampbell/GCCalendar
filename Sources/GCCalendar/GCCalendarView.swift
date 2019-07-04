//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

public struct GCCalendarView: View {
    @State var calendar: Calendar = .current
    @State var selectedDate: Date = Date()
    
    private var dates: [[Date?]] {
        return GCCalendar.datesForMonth(withDate: self.selectedDate, inCalendar: .current)
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            GCCalendarHeaderView(calendar: self.$calendar)
            GCCalendarMonthView(dates: self.dates, calendar: self.$calendar, selectedDate: self.$selectedDate)
        }
        .padding(10)
    }
}

#if DEBUG
struct GCCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
