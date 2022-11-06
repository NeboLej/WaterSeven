//
//  WSPlantVM.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

protocol WSPlantCellActionListenerProtocol {
    func onClick(plantId: String)
}

class WSPlantCellVM: ObservableObject, Identifiable {
    
    let id: String
    @Published var name: String
    @Published var image: String
    @Published var comment: String
    
    private var parent: Any?
    
    init(plant: WSPlant, parent: Any?) {
        self.id = plant.id
        self.name = plant.name
        self.image = plant.image ?? ""
        self.comment = plant.comment ?? ""
        self.parent = parent
    }
    
    func onClick() {
        (parent as! WSPlantCellActionListenerProtocol).onClick(plantId: id)
    }
}
