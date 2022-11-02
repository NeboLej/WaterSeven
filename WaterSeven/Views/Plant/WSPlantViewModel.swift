//
//  WSPlantViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import UIKit


class WSPlantViewModel: WSViewModel, ObservableObject {
    
    let id: Int!
    var name: String!
    var comment: String!
    var period: Int!
    @Published var image: UIImage?
    
    var daysTest: [Date] = [
        getSampleDate(offset: -1),
        getSampleDate(offset: -3),
        getSampleDate(offset: -5),
        getSampleDate(offset: -7),
        getSampleDate(offset: 0),
    ]
    @Published var calendarVM: WSCalendarVM
    
    init(service: String) {
        id = 2
        name = "Фикус Сергей"
        comment = "Покиньте горящее здание. Не пытайтесь спасти имущество, компьютеры, бумаги... Жизнь важнее!"
        image = UIImage(named: "plant1")
        period = 4
        calendarVM = WSCalendarVM(wateringDays: daysTest)
        super.init()
    }
    
    func toReadDay(day: Int) -> String {
        if day == 1 {return "день"}
        if day > 1 && day < 5 { return "дня"}
        return "дней"
    }
    
    func nextWaterung() -> String {
        return "завтра"
    }
}



//TEST
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    return calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()
}

struct WSDateModel: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
