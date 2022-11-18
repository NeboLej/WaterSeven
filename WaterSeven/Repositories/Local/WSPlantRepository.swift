//
//  WSPlantRepository.swift
//  WaterSeven
//
//  Created by Nebo on 18.11.2022.
//

import Foundation

protocol WSPlantRepositoryProtocol {
    func savePlant(_ plant: WSPlant) -> Bool
}

class WSPlantRepository: WSRepositoryLocal, WSPlantRepositoryProtocol {
    
    let storeManager: WSStoreManagerProtocol
    
    init(storeManager: WSStoreManagerProtocol) {
        self.storeManager = storeManager
    }
    
    func savePlant(_ plant: WSPlant) -> Bool {
        true
    }
    
    
}
