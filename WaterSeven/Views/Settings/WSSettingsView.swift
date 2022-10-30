//
//  WSSettingsView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSSettingsView: View {
    
    @State var date = Date()
    
    var body: some View {
        Text("")
//        WSCalendarView(currentDate: $date)
    }
}

func color(fraction: Double) -> Color {
    Color(red: fraction, green: 1 + fraction, blue: 0.5)
}

struct WSSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WSSettingsView()
    }
}
