//
//  WSHomeViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 16.10.2022.
//

import Foundation
import RealmSwift
import Combine

class WSHomeViewModel: WSViewModel, ObservableObject, WSPlantSquareActionProtocol, WSPlantCellActionListenerProtocol {

    let plantService: WSPlantServiceProtocol
    
    //TEST
    private var basePlants: [WSPlant] = [
//        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "вашему вниманию предоставляется", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [], history: [Date()] ),
//        WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ),
//        WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] )
    ]

    
    @Published var plantsToday: [WSPlantSquareCellVM] = []
    @Published var plants: [WSPlantCellVM] = []
    @Published var isGoToPlantSheet = false
    @Published var isGoToNewPlantSheet = false
    
    private var cancellableSet: Set<AnyCancellable> = []

    var plantSheet: WSPlantViewModel!
    var newPlantSheet: WSNewPlantViewModel!
    
    init(servicesFactory: WSServicesFactoryProtocol) {
        plantService = servicesFactory.plantService
        super.init()
        
        weak var _self = self
        
        plantsToday = basePlants.map { WSPlantSquareCellVM(plant: $0, parent: _self) }
        plants = basePlants.map { WSPlantCellVM(plant: $0, parent: _self) }
        
        plantService.plants
            .sink {
                _self?.plants = $0.map { WSPlantCellVM(plant: $0, parent: _self) }
                _self?.plantsToday = $0.map { WSPlantSquareCellVM(plant: $0, parent: _self) }
                _self?.basePlants = $0.map { $0 }
            }
            .store(in: &cancellableSet)
    }
    
    func addNewPlant() {
        newPlantSheet = WSNewPlantViewModel(plantService: plantService)
        isGoToNewPlantSheet = true
    }
    
    //MARK: - WSPlantSquareActionProtocol
    func onClick(plantId: UInt64) {
        guard let plant = basePlants.filter({ $0.id == plantId }).first else { return }
        plantSheet = WSPlantViewModel(plant: plant)
        isGoToPlantSheet = true
    }
    
    func onClickSuccess(plantId: UInt64) {
        let plant = plantsToday.filter{ $0.id == plantId }.first
        plant?.isWatering.toggle()
    }
}

