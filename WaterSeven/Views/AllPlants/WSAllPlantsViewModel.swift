//
//  WSAllPlantsViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

class WSAllPlantsViewModel: WSViewModel, ObservableObject, WSPlantCellActionListenerProtocol {
   
    let plants: [WSPlant] = [
        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "вашему вниманию предоставляется", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] )
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
        newPlantSheet = WSNewPlantViewModel()
        isGoToNewPlantSheet = true
    }
    
    //MARK: - WSPlantCellActionListenerProtocol
    func onClick(plantId: String) {
        guard let plant = plants.filter({ $0.id == plantId }).first else { return }
        plantSheet = WSPlantViewModel(plant: plant)
        isGoToPlantSheet = true
    } 
}

