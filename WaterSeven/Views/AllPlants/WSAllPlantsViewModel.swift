//
//  WSAllPlantsViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

class WSAllPlantsViewModel: WSViewModel {
    
    let plants: [WSPlantVM] = [ .init(name: "Кактус", image: "plant1", comment: "Не поливать"),
                                .init(name: "Ромашка Сергей", image: "plant2", comment: ""),
                                .init(name: "Борщевик", image: "plant1", comment: "Нужно избаваться"),
                                .init(name: "Дуб", image: "plant2", comment: "Не более ведра"),
                                .init(name: "Травка муравка", image: "plant1", comment: ""),
                                .init(name: "Привет Андрей", image: "plant2", comment: "Ну здравтсвуй")]
    
    
}

