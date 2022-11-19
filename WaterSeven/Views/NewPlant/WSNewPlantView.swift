//
//  WSNewPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import SwiftUI

struct WSNewPlantView: View {
    
    @ObservedObject var viewModel: WSNewPlantViewModel
    @State private var isAllertShow = false
    @State private var imageSize = CGSize()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            header
            ZStack(alignment: .top) {
                WSImageView(selectedImage: $viewModel.image, isEdit: true)
                    .readSize { size in imageSize = size }
                VStack(spacing: 0)  {
//                    Spacer(minLength: imageSize.height/1.6)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            WSTextField(placeholder: "Название*", text: $viewModel.name)
                                .padding(.top, 30)
                            WSTextField(placeholder: "Комментарий", text: $viewModel.comment)
                                .padding(.top, 20)
                            WSWateringRegimeView()
                                .padding()
                            Spacer(minLength: 300)
                        }
                        .background {
                            Image(uiImage: viewModel.image ?? UIImage(named: "defaultImage")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(1)
                                .blur(radius: 40)
                                .colorMultiply(Color("backgroundFirst").opacity(0.5))
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0.9), Color("backgroundFirst").opacity(0)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(30)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(0), Color("backgroundFirst").opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                    .offset(y: imageSize.height/1.6)
                }
            }
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
//                dismiss()
                viewModel.savePlant()
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
        WSNewPlantView(viewModel: .init(plantService: WSPlantService(localRepository: WSStoreManager())))
    }
}
