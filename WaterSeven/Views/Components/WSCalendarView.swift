//
//  WSCalendarView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

struct WSCalendarView: View {
    
    @Binding var currentDate: Date
    @State private var currentMonth = 0
    @State private var selectedDate = Date()
    
    private let days = ["пн", "вт", "ср", "чт", "пт", "сб", "вс"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 35) {
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(extraDate()[0])
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text(extraDate()[1])
                            .font(.title.bold())
                    }
                    Spacer(minLength: 0)
                    Button {
                        withAnimation {
                            currentMonth -= 1
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.red)
                            .font(.title2)
                    }
                    
                    Button {
                        withAnimation {
                            currentMonth += 1
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.red)
                            .font(.title2)
                    }

                }
                .padding(.horizontal)
                
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(extractDate()) { value in
                        dateCell(value: value)
                            .background (
                                Capsule()
                                    .fill(fillCell(date: value.date))
                                    .padding(.horizontal, 8)
//                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            )
                            .onTapGesture {
//                                currentDate = value.date
                                selectedDate = value.date
                            }
                    }
                }
            }
            .onChange(of: currentMonth) { newValue in
//                currentDate = getCurrentMonth()
            }
        }
    }
    private func fillCell(date: Date) -> Color {
        var color = Color.clear
        
        if isSameDay(date1: date, date2: selectedDate) {
            color = .green
        }
        if isSameDay(date1: date, date2: currentDate) {
            color = .red
        }
        
        print("ffff \(currentDate)")
        return color
    }
    
    @ViewBuilder
    private func dateCell(value: WSDateModel) -> some View {
        VStack {
            if value.day != -1 {
                
                if let day = daysTest.first(where: { date in
                    return isSameDay(date1: date, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: getCurrentMonth())
        return date.components(separatedBy: " ")
    }
    
    func extractDate()-> [WSDateModel] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap {
            return WSDateModel(day: calendar.component(.day, from: $0), date: $0)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date() )
        
        if firstWeekday != 1 {
            for _ in 0..<firstWeekday - 2 {
                days.insert(WSDateModel(day: -1, date: Date()), at: 0)
            }
        }
        return days
    }
}

struct WSCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        WSSettingsView()
    }
}

struct WSDateModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}


//TEST
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    return calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()
}

var daysTest: [Date] = [
    getSampleDate(offset: -1),
    getSampleDate(offset: -3),
    getSampleDate(offset: -5),
    getSampleDate(offset: -7),
]
