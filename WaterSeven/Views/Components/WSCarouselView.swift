//
//  WSCarouselView.swift
//  WaterSeven
//
//  Created by Nebo on 04.11.2022.
//

import SwiftUI

struct WSCarouselView: View {
    
    @Binding var cellsVM: [WSPlantSquareCellVM]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(cellsVM) { vm in
                    VStack {
                        GeometryReader { geomety in
                            WSPlantSquareCell(vm: vm)
                                .frame(width: 200, height: 270)
                                .rotation3DEffect(.degrees(Double(geomety.frame(in: .global).midX) / 15), axis: (x: 0, y: -1, z: 0))
                        }
                        .padding(.vertical)
                    }
                }.frame(width: 200, height: 300)
            }
        }
    }
}

struct WSCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
//        WSCarouselView(cellsVM: [
//            .init(plant: WSPlant(name: "Олег", comment: "коммент", image: "plant1", period: 1, wateringSchedule: [] ), parent: nil),
//            .init(plant: WSPlant(name: "Олег Бодрый", comment: "комментарий", image: "plant2", period: 1, wateringSchedule: [] ), parent: nil),
//            .init(plant: WSPlant(name: "Цветок", comment: "", image: "plant1", period: 1, wateringSchedule: [] ), parent: nil),
//            .init(plant: WSPlant(name: "Олег44", comment: "коммент", image: "plant2", period: 1, wateringSchedule: [] ), parent: nil),
//            .init(plant: WSPlant(name: "Не Олег", comment: "вашему вниманию предоставляется", image: "plant1", period: 1, wateringSchedule: [] ), parent: nil)
//        ])
    }
}
