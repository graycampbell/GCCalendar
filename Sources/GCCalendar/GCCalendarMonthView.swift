//
//  GCCalendarMonthView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarMonthView: View {
    @State var dates: [[Date?]]
    @Binding var calendar: Calendar
    @Binding var selectedDate: Date
    
    var body: some View {
        ForEach(0..<self.dates.count) { index in
            GCCalendarWeekView(dates: self.dates[index], calendar: self.$calendar, selectedDate: self.$selectedDate)
                .tag(index)
        }
    }
}

#if DEBUG
struct GCCalendarMonthView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
