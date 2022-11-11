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
            ScrollView(.vertical, showsIndicators: false) {
                header
                ForEach(viewModel.plantsVM) { vm in
                    WSPlantCell(vm: vm)
                }.padding([.horizontal, .top], 10)
            }
        }.background(Color("background"))
            .sheet(isPresented: $viewModel.isGoToNewPlantSheet) {
            WSNewPlantView(viewModel: viewModel.newPlantSheet)
        }
        .sheet(isPresented: $viewModel.isGoToPlantSheet) {
            WSPlantView(viewModel: viewModel.plantSheet)
        }
    }
    
    var header: some View {
        
        ZStack {
            Circle()
                .fill(AngularGradient(colors: [.green ,.blue, .green], center: .center))
                .offset(x: -100, y: 100)
                
            WSGlassView {
                VStack{
                    Text("Текст 1")
                        .foregroundColor(.black)
                    Text("Текст 2")
                    Text("Текст 3")
                    WSButtonOne(action: {
                        viewModel.addPlant()
                    }, label: Text("Добавить растение"))
                }
            }
        }
        .frame(height: 150)
        .padding(.horizontal, 10)
    }
}

struct WSAllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        WSAllPlantsView(viewModel: WSAllPlantsViewModel())
    }
}
