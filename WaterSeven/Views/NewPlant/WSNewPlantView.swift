//
//  WSNewPlantView.swift
//  WaterSeven
//
//  Created by Nebo on 21.10.2022.
//

import SwiftUI

struct WSNewPlantView: View {
    @ObservedObject var viewModel: WSNewPlantViewModel
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            Content(viewModel: viewModel, safeArea: safeArea, size: size)
        }
    }
}

fileprivate struct Content: View {
    @ObservedObject var viewModel: WSNewPlantViewModel
    var safeArea: EdgeInsets
    var size: CGSize
    
    @State private var isAllertShow = false
    @State private var imageSize = CGSize()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                imagePickerView(selectedImage: $viewModel.image, isEdit: true)
                editView()
            }
            .overlay(alignment: .top) {
                header()
            }
        }
        .interactiveDismissDisabled()
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundFirst").opacity(1), Color("backgroundFirst").opacity(0.8)]), startPoint: .top, endPoint: .bottom))
        
        .alert("Изменения не сохранятся", isPresented: $isAllertShow) {
            alert()
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY - 57
            
            HStack(spacing: 15) {
                Button {
                    isAllertShow = true
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Новое растение")
                    .foregroundColor(Color("background3"))
                Spacer()
                
                Button {
                    viewModel.savePlant()
                    dismiss()
                } label: {
                    Text("Сохранить")
                        .font(.custom(WSFont.medium, size: 14))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                        .foregroundColor(Color("background3"))
                }
            }
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 10)
            .background(LinearGradient(colors: [.black.opacity(minY < -270 ? 1 : 0.8),
                                                .black.opacity(minY < -270 ? 1 : 0.5),
                                                .black.opacity(minY < -270 ? 1 : 0)],
                                       startPoint: .top, endPoint: .bottom))
            .offset(y: -minY)
        }
        .frame(height: 35)
    }
    
    @ViewBuilder
    func imagePickerView(selectedImage: Binding<UIImage?>, isEdit: Bool) -> some View {
        let height = size.height * 0.45
        
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height*0.9)
            
            WSImageView(selectedImage: selectedImage, isEdit: isEdit)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 1))
                .clipped()
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        //GRADIENT OVERLAY
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                Color("backgroundFirst").opacity(0 - progress),
                                Color("backgroundFirst").opacity(0.1 - progress),
                                Color("backgroundFirst").opacity(0.3 - progress),
                                Color("backgroundFirst").opacity(0.4 - progress)
                            ], startPoint: .top, endPoint: .bottom))
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func editView() -> some View {
        VStack(spacing: 0)  {
            WSTextField(placeholder: "Название*", text: $viewModel.name)
                .padding(.top, 30)
            WSTextField(placeholder: "Комментарий", text: $viewModel.comment)
                .padding(.top, 20)
            WSWateringRegimeView()
                .padding()
        }
    }
    
    @ViewBuilder
    func alert() -> some View {
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


struct WSNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        WSNewPlantView(viewModel: .init(plantService: WSPlantService(localRepository: WSStoreManager())))
    }
}
