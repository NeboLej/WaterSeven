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
    @Binding var isEdit: Bool
    
    var body: some View {
        
        VStack {
            if selectedImage != nil {
                ZStack {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //                            .clipShape(Circle())
                    //                            .frame(width: 300, height: 300)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            isConformShow = true
                        }
                    
                    if isEdit {
                        VStack() {
    //                        Spacer()
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 150)
                                .foregroundColor(Color("info"))
                                .padding(.top, 50)
                            Text("+ Изменить изображение")
                                .foregroundColor(Color("info"))
                                .font(.custom(WSFont.light, size: 18))
                                .padding(.top, 15)
                                .padding(.bottom, 60)
                        }
                        .onTapGesture {
                            isConformShow = true
                        }     
                    }
                }
                
            } else {
                VStack {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 150)
                        .foregroundColor(Color("info"))
                        .padding(.top, 50)
                    Text("+ Добавить изображение")
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
        WSImageView(selectedImage: .init(get: { UIImage(named: "plant1") }, set: { _ in }), isEdit: .init(get: { false }, set: { _ in }))
    }
}
