//
//  WSPlantVM.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

class WSPlantCellVM: ObservableObject, Identifiable {
    
    @Published var name: String
    @Published var image: String
    @Published var comment: String
    
    private var parent: Any?
    
    init(plant: WSPlant, parent: Any?) {
        self.name = plant.name
        self.image = plant.image ?? ""
        self.comment = plant.comment ?? ""
        self.parent = parent
    }
    
    func clickComplite() {
        
    }
    
    func onClick() {
        
    }
}
