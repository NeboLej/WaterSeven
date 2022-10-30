//
//  WSCalendarVM.swift
//  WaterSeven
//
//  Created by Nebo on 30.10.2022.
//

import Foundation

class WSCalendarVM: ObservableObject {
    
    @Published var currentDate: Date = Date()
    @Published var selectedDate: Date = Date()
    @Published var currentMonth = 0
    
    @Published var wateringDays: [Date]
    
    init(wateringDays: [Date]) {
        self.wateringDays = wateringDays
    }
    
    let days = ["пн", "вт", "ср", "чт", "пт", "сб", "вс"]
     
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY LLLL"
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
