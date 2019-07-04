//
//  GCCalendarHeaderView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarHeaderView: View {
    @Binding var calendar: Calendar
    
    private var weekdaySymbols: [String] {
        return GCCalendar.weekdaySymbols(forCalendar: self.calendar)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<self.weekdaySymbols.count) { index in
                GCCalendarWeekdayLabel(title: self.weekdaySymbols[index])
                    .tag(index)
            }
        }
    }
}

#if DEBUG
struct GCCalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
