//
//  WSPlant.swift
//  WaterSeven
//
//  Created by Nebo on 04.11.2022.
//

import Foundation

struct WSPlant: Identifiable {
    var id: UInt64
    let name: String
    let comment: String
    let image: String
    let period: Int
    let wateringSchedule: [Int]
    let history: [Date]
    
    init(name: String, comment: String = "", image: String = "", period: Int = -1, wateringSchedule: [Int] = [], history: [Date] = []) {
        self.id = UInt64(UUID().uuid.0)
        self.name = name
        self.comment = comment
        self.image = image
        self.period = period
        self.wateringSchedule = wateringSchedule
        self.history = history
    }
    
    init(storedModel: WSPlantStored) {
        self.id = storedModel.id
        self.name = storedModel.name
        self.comment = storedModel.comment
        self.image = storedModel.image
        self.period = storedModel.period
        self.wateringSchedule = Array(storedModel.wateringSchedule)
        self.history = Array(storedModel.history)
    }
}
