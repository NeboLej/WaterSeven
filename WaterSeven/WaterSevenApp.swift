//
//  WaterSevenApp.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

@main
struct WaterSevenApp: App {
    
    let serviceFactory: WSServiceFactoryProtocol
    
    init() {
        serviceFactory = WSServicesFactory()
    }
    var body: some Scene {
        WindowGroup {
            WSHomeView(viewModel: WSHomeViewModel(serviceFactory: serviceFactory))
        }
    }
}
