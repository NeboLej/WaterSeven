//
//  Date +.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import Foundation

extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: startDate)! }
    }
    
    func isSameDay(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: self)
    }
    
}
