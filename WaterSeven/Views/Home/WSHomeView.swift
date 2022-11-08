//
//  WSHomeView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct WSHomeView: View {
    
    @ObservedObject var viewModel: WSHomeViewModel
    @State var isSheet = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WSTodayWaterView(wateringToday: viewModel.plantsToday.map{ $0.name })
                .frame(height: screenSize.height / 2.5)
            
            if !viewModel.plantsToday.isEmpty {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(Color("backgroundFirst"))
                        .frame(height: 100)
                    WSCarouselView(cellsVM: $viewModel.plantsToday)
                }
            }
            
            if !viewModel.plants.isEmpty {
                VStack(alignment: .leading) {
                    Text("В ближайшие дни")
                        .font(.custom(WSFont.medium, size: 20))
                        .foregroundColor(Color("backgroundFirst"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                    Rectangle()
                        .fill(Color("backgroundFirst"))
                        .frame(width: screenSize.width/1.4 ,height: 3)
                    ForEach(viewModel.plants) { plant in
                        WSPlantCell(vm: plant)
                    }
                    .padding(.horizontal, 10)
                }
            } else {
                emptyPlant
                    .padding(.horizontal, 12)
            }
            
        }.background(Color("background"))
            .sheet(isPresented: $viewModel.isGoToPlantSheet) {
                WSPlantView(viewModel: viewModel.plantSheet)
            }
            .sheet(isPresented: $viewModel.isGoToNewPlantSheet) {
                WSNewPlantView(viewModel: viewModel.newPlantSheet)
            }
    }
    
    
    @ViewBuilder
    var emptyPlant: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ZStack {
                    Text("В ближайшие дни нет растений, требующих полива")
                        .font(.custom(WSFont.medium, size: 16))
                        .foregroundColor(Color("background3"))
                        .padding(.horizontal)
                    Circle()
                        .fill(AngularGradient(colors: [.white.opacity(0.2), .white.opacity(0.4), .white.opacity(0.2)], center: .center))
                        .padding()
                        .shadow(color: .black, radius: 10, x: 2, y: 2)
                        .offset(x: -90, y: -110)
                    Circle()
                        .fill(AngularGradient(colors: [.white.opacity(0.3), .white.opacity(0.6), .white.opacity(0.3)], center: .center))
                        .padding()
                        .shadow(color: .black, radius: 10, x: 2, y: 2)
                        .offset(x: 180, y: 100)
                }
                Spacer()
            }
            
            WSButtonOne(action: {
                viewModel.addNewPlant()
            }, label: Text("Добавить растение"))
            .padding(.bottom, 12)
        }
        .background(Color("backgroundFirst").opacity(0.95))
        .cornerRadius(20)
        .frame(height: 250)
        .clipped()
    }
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel())
        //        emptyPlant
    }
}
