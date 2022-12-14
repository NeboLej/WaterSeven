//
//  WSImageView.swift
//  WaterSeven
//
//  Created by Nebo on 29.10.2022.
//

import SwiftUI

struct WSImageView: View {
    
    @Binding var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType!
    @State private var isConformShow = false
    @State private var isImagePickerShow = false
    var isEdit: Bool
    
    var body: some View {
        
        VStack {
            if selectedImage != nil {
                ZStack(alignment: .top) {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
 
                    if isEdit {
                        VStack() {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            Text("Изменить изображение")
                                .foregroundColor(Color(.white))
                                .font(.custom(WSFont.light, size: 18))
                                .padding(10)
                        }
                        .padding()
                        .onTapGesture {
                            isConformShow = true
                        }     
                    }
                }
                
            } else {
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100)
                        .foregroundColor(Color("info"))
                        .padding(.top, 50)
                    Text("+ Нет изображения")
                        .foregroundColor(Color("info"))
                        .font(.custom(WSFont.light, size: 16))
                        .padding(.top, 15)
                        .padding(.bottom, 60)
                }.frame(maxWidth: .infinity)
                    .background(Color.white)
                    .onTapGesture {
                        isConformShow = true
                    }
            }
        }
        .confirmationDialog("Что использовать?", isPresented: $isConformShow, titleVisibility: .visible) {
            Button() {
                sourceType = .camera
                isImagePickerShow.toggle()
            } label: {
                Text("Камера")
            }
            Button() {
                sourceType = .photoLibrary
                isImagePickerShow.toggle()
            } label: {
                Text("Галерея")
            }
            Button() {
                
            } label: {
                Text("Готовое изображеине")
            }
            
            Button(role: .cancel) {
                
            } label: {
                Text("отмена")
            }
        }
        .sheet(isPresented: $isImagePickerShow) {
            WSImagePickerView(selectedImage: $selectedImage, sourceType: sourceType) }
    }
    
}

struct WSImageView_Previews: PreviewProvider {
    static var previews: some View {
        WSNewPlantView(viewModel: .init(plantService: WSPlantService(localRepository: WSStoreManager())))
    }
}
