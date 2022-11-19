//
//  WSPlantCellView.swift
//  WaterSeven
//
//  Created by Nebo on 19.10.2022.
//

import SwiftUI

struct WSPlantCell: View {
    
    @ObservedObject var vm: WSPlantCellVM
    @State private var cellSize = CGSize()
    
    var body: some View {
        HStack {
            Image(vm.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack( alignment: .leading ) {
                Text(vm.name)
                    .foregroundColor(.white)
                    .font(.custom(WSFont.medium, size: 20))
                Text(vm.comment)
                    .foregroundColor(.white)
                    .font(.custom(WSFont.medium, size: 10))
                Spacer()
                HStack {
                    Text("Полить: ")
                        .foregroundColor(.white)
                        .font(.custom(WSFont.medium, size: 14))
                    Text("день")
                        .foregroundColor(.white)
                        .font(.custom(WSFont.medium, size: 14))
                }
            }
            .padding([.top, .bottom], 12)
            Spacer()
        }
        .frame(height: 85)
        .background(WSRoundedCornersShape(corners: [.topRight, .bottomRight], radius: 27).fill(Color("backgroundFirst").opacity(0.95)))
        .onTapGesture {
            vm.onClick()
        }
    }
}

struct WSPlantCellView_Previews: PreviewProvider {
    static var previews: some View {
        WSPlantCell(vm: WSPlantCellVM(plant: WSPlant(name: "Привет Андрей", comment: "комментарий к растению", image: "plant2", period: 2, wateringSchedule: []), parent: nil))
    }
}
