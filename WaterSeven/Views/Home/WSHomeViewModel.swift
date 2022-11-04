//
//  WSHomeViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 16.10.2022.
//

import Foundation

class WSHomeViewModel: WSViewModel, ObservableObject, WSPlantSquareActionProtocol {

    private let basePlants: [WSPlant] = [
        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] )
    ]
    
    @Published var plants1: [WSPlantCellVM] = []
    @Published var plantsToday: [WSPlantSquareCellVM] = []
    @Published var plants: [WSPlantCellVM] = []
    @Published var isGoToSheet = false
    
    var routeSheet: WSPlantViewModel!

    
    override init() {
        super.init()
        
        weak var _self = self
        
        plants1 = []
        
        plantsToday = basePlants.map { WSPlantSquareCellVM(plant: $0, parent: _self) }
        plants = basePlants.map { WSPlantCellVM(plant: $0, parent: _self) }
    }
    
    
    //MARK: - WSPlantSquareActionProtocol
    func onClick(plantId: String) {
        guard let plant = basePlants.filter({ $0.id == plantId }).first else { return }
        routeSheet = WSPlantViewModel(plant: plant)
        isGoToSheet = true
        print(plantId)
    }
    
    func onClickSuccess(plantId: String) {
        let plant = plantsToday.filter{ $0.id == plantId }.first
        plant?.isWatering = true
    }
}
