//
//  WaterSevenApp.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

let screenSize = UIScreen.main.bounds

@main
struct WaterSevenApp: App {
    
    let serviceFactory: WSServicesFactoryProtocol
    
    init() {
        serviceFactory = WSServicesFactory()
    }
    var body: some Scene {
        WindowGroup {
//            WSHomeView(viewModel: WSHomeViewModel())
            
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            WSTabView(viewModel: WSTabViewModel(servicesFactory: serviceFactory))
        }
    }
}
