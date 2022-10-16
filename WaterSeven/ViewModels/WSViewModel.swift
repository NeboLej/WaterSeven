//
//  WSViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 16.10.2022.
//

import Foundation

class WSViewModel {
    
    let serviceFactory: WSServiceFactoryProtocol
    
    init(serviceFactory: WSServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }
    
}
