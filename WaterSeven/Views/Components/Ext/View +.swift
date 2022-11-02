//
//  View +.swift
//  WaterSeven
//
//  Created by Nebo on 30.10.2022.
//

import SwiftUI

extension View {
    
    func addPopOver<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content ) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack {
                    if show.wrappedValue {
                        content()
                    }
                }
        }
    }
    
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


