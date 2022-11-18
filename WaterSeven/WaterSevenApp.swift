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
    
    let serviceFactory: WSServiceFactoryProtocol
    
    init() {
        serviceFactory = WSServicesFactory()
    }
    var body: some Scene {
        WindowGroup {
//            WSHomeView(viewModel: WSHomeViewModel())
            
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnstatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            WSTabView()
        }
    }
}
