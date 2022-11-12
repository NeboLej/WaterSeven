//
//  WSHomeView.swift
//  WaterSeven
//
//  Created by Nebo on 15.10.2022.
//

import SwiftUI

struct WSHomeView: View {
    
    @ObservedObject var viewModel: WSHomeViewModel
    @State private var animationAmount = 0.0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            WSTodayWaterView(wateringToday: viewModel.plantsToday.map{ $0.name })
                .frame(height: screenSize.height / 2.7)
            
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
                        .font(.custom(WSFont.medium, size: 22))
                        .foregroundColor(Color("backgroundFirst"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 1)
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
            
//            Button("Tap Me") {
////                 animationAmount += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(.red)
//                    .scaleEffect(animationAmount)
//                    .opacity(2 - animationAmount)
//                    .animation(
//                        .easeInOut(duration: 1)
//                            .repeatForever(autoreverses: true),
//                        value: animationAmount
//
//                    )
//
//            )
//            .onAppear {
//                animationAmount = 2
//            }

            
        }.background(Color.white)
            .sheet(isPresented: $viewModel.isGoToPlantSheet) {
                WSPlantView(viewModel: viewModel.plantSheet)
            }
            .sheet(isPresented: $viewModel.isGoToNewPlantSheet) {
                WSNewPlantView(viewModel: viewModel.newPlantSheet)
            }
    }
    
    
    @ViewBuilder
    var emptyPlant: some View {
        
        WSGlassView(blurRadius: 10, saturation: 1.8) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ZStack {
                        
                        Text("В ближайшие дни нет растений, требующих полива")
                            .font(.custom(WSFont.medium, size: 16))
                            .foregroundColor(Color("background3"))
                            .padding(.horizontal)
                        Circle()
                            .fill(AngularGradient(colors: [.white.opacity(0.2), .red.opacity(0.4), .white.opacity(0.2)], center: .center))
                            .padding()
                            .transformEffect(CGAffineTransform(rotationAngle: animationAmount))
//                            .shadow(color: .black, radius: 10, x: 2, y: 2)
//                            .offset(x: -90, y: -110)
                            
                            .animation(
                                .easeInOut(duration: 3)
                                    .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                            .onAppear {
                                animationAmount = 2
                            }
                        
                        Circle()
                            .fill(AngularGradient(colors: [.white.opacity(0.3), .white.opacity(0.6), .white.opacity(0.3)], center: .center))
                            .padding()
                            .shadow(color: .black, radius: 10, x: 2, y: 2)
                            .offset(x: 180, y: 100)
                    }
                    .overlay(
                        Circle()
                            .fill(AngularGradient(colors: [.white.opacity(0.3), .red.opacity(0.6), .white.opacity(0.3)], center: .center))
                            .rotationEffect(.degrees(-180 * animationAmount))
//                            .stroke(.red)
//                            .scaleEffect(animationAmount)
//                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: true),
                                value: animationAmount

                            )

                    )
                    .onAppear {
                        animationAmount = 3
                    }
                    
                    Spacer()
                }
                
                
                WSButtonOne(action: {
                    viewModel.addNewPlant()
                }, label: Text("Добавить растение"))
                .padding(.bottom, 12)
            }
        }
        .mask{
            RoundedRectangle(cornerRadius: 25)
        }
        .frame(height: 250)
    }
}

struct WSHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WSHomeView(viewModel: WSHomeViewModel())
//        emptyPlant
    }
}
