//
//  WSHomeViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 16.10.2022.
//

import Foundation

class WSHomeViewModel: WSViewModel, ObservableObject, WSPlantSquareActionProtocol, WSPlantCellActionListenerProtocol {

    private let basePlants: [WSPlant] = [
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
    
//    @Published var plants1: [WSPlantCellVM] = []
    @Published var plantsToday: [WSPlantSquareCellVM] = []
    @Published var plants: [WSPlantCellVM] = []
    @Published var isGoToPlantSheet = false
    @Published var isGoToNewPlantSheet = false
    
    
    var plantSheet: WSPlantViewModel!
    var newPlantSheet: WSNewPlantViewModel!
    
    override init() {
        super.init()
        
        weak var _self = self
        
//        plants1 = []
        
        plantsToday = basePlants.map { WSPlantSquareCellVM(plant: $0, parent: _self) }
        plants = basePlants.map { WSPlantCellVM(plant: $0, parent: _self) }
    }
    
    func addNewPlant() {
        newPlantSheet = WSNewPlantViewModel()
        isGoToNewPlantSheet = true
    }
    
    //MARK: - WSPlantSquareActionProtocol
    func onClick(plantId: String) {
        guard let plant = basePlants.filter({ $0.id == plantId }).first else { return }
        plantSheet = WSPlantViewModel(plant: plant)
        isGoToPlantSheet = true
    }
    
    func onClickSuccess(plantId: String) {
        let plant = plantsToday.filter{ $0.id == plantId }.first
        plant?.isWatering = true
    }
}
