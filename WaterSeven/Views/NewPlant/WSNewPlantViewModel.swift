//
//  WSNewPlantViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import UIKit

class WSNewPlantViewModel: WSViewModel, ObservableObject {
    
    @Published var image: UIImage? = UIImage(named: "plant1")
    @Published var name = ""
    @Published var comment = ""
    
}
