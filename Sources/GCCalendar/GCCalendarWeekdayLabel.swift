//
//  GCCalendarWeekdayLabel.swift
//  GCCalendar
//
//  Created by Gray Campbell on 7/3/19.
//

import SwiftUI

struct GCCalendarWeekdayLabel: View {
    let title: String
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                Text(self.title)
                    .color(.gray)
                    .font(.caption)
                    .bold()
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
        }
    }
}

#if DEBUG
struct GCCalendarWeekdayLabel_Previews: PreviewProvider {
    static var previews: some View {
        GCCalendarView()
            .frame(maxHeight: 370)
    }
}
#endif
