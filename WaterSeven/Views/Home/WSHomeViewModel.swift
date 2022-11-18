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

    private let basePlants: [WSPlant] = [
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
    
    @Published var realmManager = RealmManager()
    
//    @Published var plants1: [WSPlantCellVM] = []
    @Published var plantsToday: [WSPlantSquareCellVM] = []
    @Published var plants: [WSPlantCellVM] = []
    @Published var isGoToPlantSheet = false
    @Published var isGoToNewPlantSheet = false
    
    @Published var tmpModels: [TmpModel2] = [] {
        willSet {
            print(newValue)
        }
    }
    
    private var cancellableSet: Set<AnyCancellable> = []

    
    var plantSheet: WSPlantViewModel!
    var newPlantSheet: WSNewPlantViewModel!
    
    override init() {
        super.init()
        
        weak var _self = self
        
//        tmpModels = realmManager.tmpModels
//        plants1 = []
        
        plantsToday = basePlants.map { WSPlantSquareCellVM(plant: $0, parent: _self) }
        plants = basePlants.map { WSPlantCellVM(plant: $0, parent: _self) }
        
        
        realmManager.tmpModelsPublisher
            .sink { models in
                self.tmpModels = models.map {TmpModel2(model: $0)}
            }
            .store(in: &cancellableSet)

    }
//    func updateBD() {
//        tmpModels = realmManager.tmpModels
//    }
    
    func addNewPlant() {
//        newPlantSheet = WSNewPlantViewModel()
//        isGoToNewPlantSheet = true
        realmManager.addTmpModel(text: "Test Model 11111")
//        updateBD()
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

struct TmpModel2: Identifiable {
    var text: String
    var id: UInt64
    
    init(text: String) {
        self.text = text
        self.id = 2
    }
    
    init(model: TmpModel) {
        self.text = model.title
        self.id = model.id
    }
}
