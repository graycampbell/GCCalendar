//
//  GCCalendarWeekView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarWeekView: View {
    @State var dates: [Date?]
    @Binding var calendar: Calendar
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<self.dates.count) { index in
                GCCalendarDayView(date: self.dates[index], calendar: self.$calendar)
                    .tag(index)
            }
        }
    }
}

#if DEBUG
struct GCCalendarWeekView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
