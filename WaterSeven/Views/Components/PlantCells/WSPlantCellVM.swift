//
//  WSPlantVM.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

protocol WSPlantCellActionListenerProtocol {
    func onClick(plantId: UInt64)
}

class WSPlantCellVM: ObservableObject, Identifiable {
    
    let id: UInt64
    @Published var name: String
    @Published var image: String
    @Published var comment: String
    
    private var parent: Any?
    
    init(plant: WSPlant, parent: Any?) {
        id = plant.id
        name = plant.name
        image = plant.image
        comment = plant.comment
        self.parent = parent
    }
    
    func onClick() {
        (parent as! WSPlantCellActionListenerProtocol).onClick(plantId: id)
    }
}
