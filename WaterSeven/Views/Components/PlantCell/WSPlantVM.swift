//
//  WSPlantVM.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import Foundation

class WSPlantVM: Identifiable {
    
    let name: String
    let image: String
    let comment: String
    
    init(name: String, image: String, comment: String) {
        self.name = name
        self.image = image
        self.comment = comment
    }
    
    func clickComplite() {
        
    }
}
