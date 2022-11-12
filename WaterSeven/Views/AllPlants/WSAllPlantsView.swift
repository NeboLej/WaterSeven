//
//  WSAllPlantsView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSAllPlantsView: View {
    
    @ObservedObject var viewModel: WSAllPlantsViewModel

    init(viewModel: WSAllPlantsViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                circle(width: screenSize.width/1.3, opasity: 0.4)
                    .offset(x: -150, y: -100)
                
                circle(width: screenSize.width/3, opasity: 0.5)
                    .offset(x: 150, y: -270)

                circle(width: screenSize.width/3, opasity: 0.4)
                    .offset(x: 130, y: 370)

                circle(width: screenSize.width/2.6, opasity: 0.2)
                    .offset(x: -100, y: 570)

                ScrollView(.vertical, showsIndicators: false) {
                    header
                    ForEach(viewModel.plantsVM) { vm in
                        WSPlantCell(vm: vm)
                    }.padding([.horizontal, .top], 10)
                }
            }
        }.background(.white)
            .sheet(isPresented: $viewModel.isGoToNewPlantSheet) {
            WSNewPlantView(viewModel: viewModel.newPlantSheet)
        }
        .sheet(isPresented: $viewModel.isGoToPlantSheet) {
            WSPlantView(viewModel: viewModel.plantSheet)
        }
    }
    
    var header: some View {
        ZStack {
            WSGlassView(blurRadius: 10, saturation: 1.6, strokeGradient: LinearGradient(colors: [ .white.opacity(0.5), .clear, Color("backgroundFirst").opacity(0.1), Color("backgroundFirst").opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)) {
               HStack(spacing: 0) {
                   WSLottieView(name: "flower-animation2")
                       .frame(height: 270)
                       .opacity(0.8)
                       .mask {
                           Rectangle()
                               .frame(height: 150)
                       }
                   
                   VStack {
                       Image(systemName: "plus")
                           .resizable()
                           .frame(width: 35, height: 35)
                           .foregroundStyle(LinearGradient(colors: [.white.opacity(0.4), .white.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                           
                       Text("Добавить растение")
                           .foregroundColor(.white.opacity(0.7))
                   }
                   .onTapGesture {
                       viewModel.addPlant()
                   }
                }
            }
        }
        
        .frame(height: 150)
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func circle(width: CGFloat, opasity: Double) -> some View {
        Circle()
            .fill(AngularGradient(colors: [Color("backgroundFirst").opacity(opasity) ,Color("backgroundFirst").opacity(0.6), Color("backgroundFirst").opacity(opasity)], center: .center))
            .opacity(opasity)
            .frame(width: width)
    }
}

struct WSAllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        WSAllPlantsView(viewModel: WSAllPlantsViewModel())
    }
}
