//
//  WSTabViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 19.11.2022.
//

import Foundation

class WSTabViewModel: WSViewModel, ObservableObject {
    
    let servicesFactory: WSServicesFactoryProtocol
    
    init(servicesFactory: WSServicesFactoryProtocol) {
        self.servicesFactory = servicesFactory
        
        super.init()
    }
    
    
    func getHomeViewModel() -> WSHomeViewModel {
        WSHomeViewModel(servicesFactory: servicesFactory)
    }
}
