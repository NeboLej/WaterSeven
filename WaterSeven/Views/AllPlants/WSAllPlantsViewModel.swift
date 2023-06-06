//
//  WSAllPlantsViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

class WSAllPlantsViewModel: WSViewModel, ObservableObject, WSPlantCellActionListenerProtocol {
   
    let plants: [WSPlant] = [
        WSPlant(name: "Plant1", comment: "comment", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Plant2", comment: "comment", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Plant3", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Plant4", comment: "comment", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Plant5", comment: "comment comment comment comment", image: "plant1", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Plant6", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
    ]
    
    var plantSheet: WSPlantViewModel!
    var newPlantSheet: WSNewPlantViewModel!
    var plantsVM: [WSPlantCellVM]!
    
    @Published var isGoToPlantSheet = false
    @Published var isGoToNewPlantSheet = false
    
    override init() {
        super.init()
        
        weak var _self = self
        
        plantsVM = plants.map { WSPlantCellVM(plant: $0, parent: _self)}
    }
    
    func addPlant() {
        newPlantSheet = WSNewPlantViewModel(plantService: WSPlantService(localRepository: WSStoreManager())) // tmp
        isGoToNewPlantSheet = true
    }
    
    //MARK: - WSPlantCellActionListenerProtocol
    func onClick(plantId: UInt64) {
        guard let plant = plants.filter({ $0.id == plantId }).first else { return }
        plantSheet = WSPlantViewModel(plant: plant)
        isGoToPlantSheet = true
    } 
}

