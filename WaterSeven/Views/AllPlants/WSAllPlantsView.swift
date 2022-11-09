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
            HStack {
                Spacer()
                Button {
                    viewModel.addPlant()
                } label: {
                    Text("Добавить растение")
                        .foregroundColor(Color("background3"))
                }
                .padding()
            }.background(Color("backgroundFirst"))
            ScrollView(.vertical, showsIndicators: false) {
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
}

struct WSAllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        WSAllPlantsView(viewModel: WSAllPlantsViewModel())
    }
}
