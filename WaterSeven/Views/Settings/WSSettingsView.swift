//
//  WSSettingsView.swift
//  WaterSeven
//
//  Created by Nebo on 20.10.2022.
//

import SwiftUI

struct WSSettingsView: View {
    
    @ObservedObject var viewModel: WSSettingsViewModel

    
    @State var pickerSection = 0
    @State var slider = 1.0
    @State var toggle = false
    @State var tmp = false
    var pickerContent = ["1", "2", "3"]
    
    var body: some View {
        NavigationView
        {
            Form {
                Section {
                    Text("Секция 1")
                        .fontWeight(.semibold)
                    Text("Тема")
                    Text("О приложении")
                    Text("----------------------------")

                }

                
                Section{
                    Text("Секция 2")
                        .fontWeight(.semibold)
                    Text("Что-то")
                    Text("Что-то")
                }
                
                
                Section {
                    Text("Секция 3")
                        .fontWeight(.semibold)
                    Picker(selection: $pickerSection) {
                        ForEach(0..<pickerContent.count) {
                            Text(pickerContent[$0])
                        }
                    } label: {
                        Text("Пикер")
                    }
                    Text("Текст")
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            tmp.toggle()
                        }
                        
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                                .frame(width: 10)
                            
                            Text("Кнопка")
                                .foregroundColor(.black)
                        }
                    }
                    if tmp {
                        Section {
                            Text("sadasd")
                            Text("sadasd")
                            Text("sadasd")
                        }
                    }
                    
                    Slider(value: $slider, label: {
                        Text("Слайдер")
                    })
                    
                    Toggle(isOn: $toggle) {
                        Text("Тогл")
                    }
                }

            }
            .navigationBarTitle("Настройки")
        }
    }
}

struct WSSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WSSettingsView(viewModel: WSSettingsViewModel())
    }
}
