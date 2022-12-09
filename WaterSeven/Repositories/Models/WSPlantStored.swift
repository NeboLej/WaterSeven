//
//  WSPlantStored.swift
//  WaterSeven
//
//  Created by Nebo on 18.11.2022.
//

import Foundation
import RealmSwift

class WSPlantStored: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var comment: String
    @Persisted var image: String
    @Persisted var period: Int
    @Persisted var wateringSchedule: List<Int>
    @Persisted var history: List<Date>
    
//    init(name: String, comment: String = "", image: String = "", period: Int = -1, wateringSchedule: [Int] = [], history: [Date] = []) {
//        self.name = name
//        self.comment = comment
//        self.image = image
//        self.period = period
//        self.wateringSchedule = List<Int>()
//        self.history = List<Date>()
//        
//        super.init()
//        
//        self.history.append(objectsIn: history)
//        self.wateringSchedule.append(objectsIn: wateringSchedule)
//    }
    
    static func initModel(name: String, comment: String = "", image: String = "", period: Int = -1, wateringSchedule: [Int] = [], history: [Date] = []) -> [String: Any] {
        
        return ["name": name, "comment": comment, "image": image, "period": period, "wateringSchedule": wateringSchedule, "history": history ]
    }
    
    static func initModel(plant: WSPlant) -> [String: Any] {
        
        return ["name": plant.name, "comment": plant.comment, "image": plant.image, "period": plant.period, "wateringSchedule": plant.wateringSchedule, "history": plant.history ]
    }
}
