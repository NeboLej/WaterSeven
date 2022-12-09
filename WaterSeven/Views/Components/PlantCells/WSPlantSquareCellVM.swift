//
//  WSPlantSquareCellVM.swift
//  WaterSeven
//
//  Created by Nebo on 04.11.2022.
//

import Foundation

protocol WSPlantSquareActionProtocol {
    func onClick(plantId: UInt64)
    func onClickSuccess(plantId: UInt64)
}

class WSPlantSquareCellVM: ObservableObject , Identifiable {
    
    let id: UInt64
    let parent: Any?
    @Published var name: String
    @Published var comment: String
    @Published var imagePath: String
    @Published var isWatering: Bool
    
    let imageManager = WSImageManager()
    
    init(plant: WSPlant, parent: Any?) {
        id = plant.id
        name = plant.name
        comment = plant.comment
        imagePath =  imageManager.loadImageFromDiskWith(fileName: plant.image) ?? ""//plant.image
        isWatering = plant.history.map{ $0.isSameDay(date: Date()) }.contains(true)
        self.parent = parent
    }
    
    func onClickSuccess() {
        (parent as! WSPlantSquareActionProtocol).onClickSuccess(plantId: id)
    }
    
    func onClick() {
        (parent as! WSPlantSquareActionProtocol).onClick(plantId: id)
    }
}
