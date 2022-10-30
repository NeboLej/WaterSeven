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
    
    @ObservedObject var viewModel = WSPlantViewModel(service: "service")
    
    init() {
        comment = viewModel.comment
        name = viewModel.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    WSImageView(selectedImage: $viewModel.image, isEdit: $isEditing)
                        .padding(.bottom, -40)
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
                                .padding(.top, 8)
                            Spacer(minLength: 30)
                            
                            HStack {
                                WSCalendarView(vm: viewModel.calendarVM)
                                    .background {
                                        Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .scaleEffect(1.2)
                                            .blur(radius: 30)
                                        //                                            .clipped()
                                            .colorMultiply(Color("backgroundFirst").opacity(0.5))
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(WSRoundedCornersShape(corners: [.topLeft, .topRight], radius: 30).fill(Color("backgroundFirst").opacity(0.9)))
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
