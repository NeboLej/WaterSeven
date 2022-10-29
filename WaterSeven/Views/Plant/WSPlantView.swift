//
//  WSPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

struct WSPlantView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var isEditing = false
    
    @State var comment = ""
    @State var name = ""
    @State private var position = 0
    @State private var date = Date()
    
    @State var sizeImage = CGSize(width: 0, height: 0)
    
    let viewModel = WSPlantViewModel(service: "service")
    
    init() {
        comment = viewModel.comment
        name = viewModel.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView {
                
                VStack(spacing: 0) {
                    WSImageView()
                    VStack(spacing: 0) {
                        if isEditing {
                            WSTextField(placeholder: "Название", text: $name).padding(.top, 15)
                            WSTextField(placeholder: "комментарий", text: $comment)
                            
                            WSWateringRegimeView().padding()
                            
                        } else {
                            Text(viewModel.comment).foregroundColor(Color("background3"))
                                .font(.custom(WSFont.light, size: 16))
                                .frame(alignment: .leading)
                            Rectangle().foregroundColor(Color("background3"))
                                .frame(height: 2)
                            DatePicker("", selection: $date)
                                .datePickerStyle(.graphical)
                                .padding()
                                .foregroundColor(.red)
                                
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(WSRoundedCornersShape(corners: [.topLeft, .topRight], radius: 50).fill(Color("backgroundFirst").opacity(0.9)))
                }
            }
        }
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
    
    @ViewBuilder
    var header: some View {
        HStack(spacing: 0) {
            Button {
                //                isAllertShow = true
            } label: {
                Text("Отмена")
                    .foregroundColor(Color("background3"))
            }
            Spacer()
            
            Text("Новое растение")
                .foregroundColor(Color("background3"))
            Spacer()
            
            Button {
                if isEditing {
                    saveClick()
                } else {
                    editClick()
                }
            } label: {
                Text(isEditing ? "Сохранить" : "Изменить")
                    .foregroundColor(Color("background3"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .padding(.horizontal, 5)
        .background(Color("backgroundFirst"))
    }
    
    private func editClick() {
        isEditing = true
        comment = viewModel.comment
        name = viewModel.name
    }
    
    private func saveClick() {
        isEditing = false
        viewModel.comment = comment
        viewModel.name = name
    }
}

struct WSPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSPlantView()
    }
}
