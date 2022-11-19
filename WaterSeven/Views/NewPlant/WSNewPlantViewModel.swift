//
//  WSNewPlantViewModel.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import UIKit

class WSNewPlantViewModel: WSViewModel, ObservableObject {
    
    @Published var image: UIImage? = UIImage(named: "defaultImage")
    @Published var name = ""
    @Published var comment = ""
    @Published var period: Int = 1
    @Published var wateringSchedule: [Int] = []
    
    private let plantService: WSPlantServiceProtocol
    private let imageManager = WSImageManager()
    
    init(plantService: WSPlantServiceProtocol) {
        self.plantService = plantService
        super.init()
    }
    
    func savePlant() {
        if validation() {
            print(name)
            print(comment)
            var imageName = "defaultImage"
            if let image = image, image != UIImage(named: "defaultImage") {
                imageName = "WSImage-\(Date())"
                imageManager.saveImage(imageName: imageName, image: image)
            }
            plantService.addPlant(WSPlant(name: name,
                                           comment: comment,
                                           image: imageName,
                                           period: period,
                                           wateringSchedule: wateringSchedule,
                                           history: []))
        }
    }
    
    private func validation() -> Bool {
        return !name.isEmpty
    }
    
}
