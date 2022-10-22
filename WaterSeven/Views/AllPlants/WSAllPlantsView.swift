//
//  WSAllPlantsView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSAllPlantsView: View {
    
    private let viewModel = WSAllPlantsViewModel()
    @State private var isShowNewPlantSheet = false

    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "background")
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Spacer()
                Button {
                    isShowNewPlantSheet = true
                } label: {
                    Text("Добавить растение")
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2)
                        .foregroundColor(Color("background3"))
                }
                .padding()
            }.background(Color("backgroundFirst"))
            List {
                ForEach(viewModel.plants) { plant in
                    WSPlantCellView( viewModel: plant )
                        .listRowInsets(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
                        .listRowSeparator(.hidden)
                        .listItemTint(.clear)
                        .buttonStyle(.plain)
                        .listRowBackground(Color("background"))
                }
            }
            .listStyle(.grouped)
            .disabled(true)
        }
        .sheet(isPresented: $isShowNewPlantSheet) {
            WSNewPlantView()
        }
    }
}

struct WSAllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        WSAllPlantsView()
    }
}
