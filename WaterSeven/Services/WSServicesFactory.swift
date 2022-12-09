//
//  WSServicesFactory.swift
//  WaterSeven
//
//  Created by Nebo on 16.10.2022.
//

import Foundation

protocol WSServicesFactoryProtocol {
    
    var plantService: WSPlantServiceProtocol { get }
}

class WSServicesFactory: WSServicesFactoryProtocol {
    
    var plantService: WSPlantServiceProtocol
    private let storeManager: WSStoreManagerProtocol
    
    init() {
        storeManager = WSStoreManager()
        plantService = WSPlantService(localRepository: storeManager)
        
    }
}
