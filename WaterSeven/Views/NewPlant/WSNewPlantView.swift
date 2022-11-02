//
//  WSNewPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import SwiftUI

struct WSNewPlantView: View {
    
    @ObservedObject private var viewModel = WSNewPlantViewModel()
    @State private var isAllertShow = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            header
            WSImageView(selectedImage: $viewModel.image, isEdit: true)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    WSTextField(placeholder: "Название*", text: $viewModel.name)
                        .padding(.top, 30)
                    WSTextField(placeholder: "Комментарий", text: $viewModel.comment)
                        .padding(.top, 20)
                    WSWateringRegimeView()
                        .padding()
                }
                .background {
                    Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(1)
                        .blur(radius: 40)
                        .colorMultiply(Color("backgroundFirst").opacity(0.3))
                }
            }
            .background(WSRoundedCornersShape(corners: [.topLeft, .topRight], radius: 30).fill(Color("backgroundFirst").opacity(0.9)))
            .padding(.top, -30)
            
            Spacer()
        }
        .interactiveDismissDisabled()
        .alert("Изменения не сохранятся", isPresented: $isAllertShow) {
            Button(role: .cancel) {
                
            } label: {
                Text("Отмена")
            }
            
            Button(role: .destructive) {
                dismiss()
            } label: {
                Text("Не сохранять")
            }
        }
    }
    
    @ViewBuilder
    var header: some View {
        HStack(spacing: 0) {
            Button {
                isAllertShow = true
            } label: {
                Text("Отмена")
                    .foregroundColor(Color("background3"))
            }
            Spacer()
            
            Text("Новое растение")
                .foregroundColor(Color("background3"))
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Сохранить")
                    .foregroundColor(Color("background3"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .padding(.horizontal, 5)
        .background(Color("backgroundFirst"))
    }
}

struct WSNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSNewPlantView()
    }
}
