//
//  WSPlant.swift
//  WaterSeven
//
//  Created by Nebo on 04.11.2022.
//

import Foundation

struct WSPlant: Identifiable {
    var id = UUID().uuidString
    let name: String
    let comment: String?
    let image: String?
    let period: Int?
    let wateringSchedule: [Int]?
    let history: [Date]
    
    init(name: String, comment: String?, image: String?, period: Int?, wateringSchedule: [Int]?, history: [Date] = []) {
        self.name = name
        self.comment = comment
        self.image = image
        self.period = period
        self.wateringSchedule = wateringSchedule
        self.history = history
    }
    
}
