//
//  WSPlantViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import Foundation

class WSPlantViewModel: WSViewModel {
    
    let id: Int!
    var name: String!
    var comment: String!
    var image: String!
    
    init(service: String) {
        id = 2
        name = "Фикус Сергей"
        comment = "Покиньте горящее здание. Не пытайтесь спасти имущество, компьютеры, бумаги... Жизнь важнее!"
        image = "plant1"
        super.init()
    }
}
