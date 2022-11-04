//
//  WSPlantSquareCell.swift
//  WaterSeven
//
//  Created by Nebo on 04.11.2022.
//

import SwiftUI

struct WSPlantSquareCell: View {
    
    @ObservedObject var vm: WSPlantSquareCellVM
    
    @State private var imageSize: CGSize
    @State private var isWatering: Bool
    
    init(vm: WSPlantSquareCellVM) {
        self.vm = vm
        self.imageSize = CGSize()
        self.isWatering = vm.isWatering
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Image(vm.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .cornerRadius(20)
                    .readSize { size in
                        imageSize = size
                    }
                    .padding(.bottom, -imageSize.height/5)
                if vm.isWatering {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("background"), lineWidth: 2)
                        Text("ПОЛИТО")
                            .foregroundColor(Color("background"))
                    }.frame(width: imageSize.width/1.5, height: 34)
                        .rotationEffect(.init(radians: -.pi/9))

                }
            }
            .onTapGesture {
                vm.onClick()
            }

            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(vm.name)
                            .foregroundColor(Color("background3"))
                            .font(.custom(WSFont.medium, size: 15))
                        Text(vm.comment)
                            .foregroundColor(Color("background3"))
                            .font(.custom(WSFont.light, size: 9))
                    }
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color("background3"))
                            .frame(width: 46, height: 46)
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("backgroundFirst").opacity(0.3), lineWidth: 1)
                                    .shadow(color: Color.black.opacity(0.7), radius: 1, x: 0, y: 1)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: -1)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            })
                        Image(systemName: "checkmark")
                            .foregroundColor(Color("backgroundFirst"))
                    }
                    .onTapGesture {
                        vm.onClickSuccess()
                    }
                }
                .padding(11)
                .frame(height: 90)
                
            }
            .frame(maxWidth: .infinity)
            .background(Color("backgroundFirst").opacity(0.9))
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.4), radius: 2, x: 0, y: 5)
        }
            .overlay{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("background"), lineWidth: 1)
                    .shadow(color: Color.black.opacity(0.7), radius: 1, x: 0, y: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: -3)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
//            .frame(maxWidth: 163, maxHeight: 222)
    }
}

struct WSPlantSquareCell_Previews: PreviewProvider, WSPlantSquareActionProtocol {
    
    func onClick(plantId: String) {
        
    }
    
    func onClickSuccess(plantId: String) {
        print(plantId)
    }
    
    static var previews: some View {
        WSPlantSquareCell(vm: WSPlantSquareCellVM(plant: WSPlant(name: "Фикус Георгий третий", comment: "комментарий короткий", image: "plant2", period: 0, wateringSchedule: [], history: [] ), parent: self))
    }
}
