//
//  WSPlantService.swift
//  WaterSeven
//
//  Created by Nebo on 18.11.2022.
//

import Foundation
import Combine

protocol WSPlantServiceProtocol {
    var plants: CurrentValueSubject<[WSPlant], Never> { get }
    
    func addPlant(_ plant: WSPlant)
}

class WSPlantService: WSService, WSPlantServiceProtocol {
    
    let repository: WSStoreManagerProtocol
    let plants = CurrentValueSubject<[WSPlant], Never>([])
    
    init(localRepository: WSStoreManagerProtocol) {
        self.repository = localRepository
    }
    
    func addPlant(_ plant: WSPlant) {
        let storeModel = WSPlantStored(value: WSPlantStored.initModel(plant: plant))
        repository.saveObject(storeModel)
    }
    
    func getPlants() {
        
    }
    
}
