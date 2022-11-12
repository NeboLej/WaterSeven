//
//  WSGlassView.swift
//  WaterSeven
//
//  Created by Nebo on 11.11.2022.
//

import SwiftUI

struct WSGlassView<Content>: View where Content : View {
    
    @State private var blurView: UIVisualEffectView = .init()

    var content: Content
    var blurRadius: CGFloat
    var saturation: CGFloat
    var strokeGradient: LinearGradient
    
    init(blurRadius: CGFloat = 10, saturation: CGFloat = 1.6, strokeGradient: LinearGradient = LinearGradient(colors: [ .white.opacity(0.5), .clear, .purple.opacity(0.2), .purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing), @ViewBuilder content: () -> Content) {
        self.content = content()
        self.blurRadius = blurRadius
        self.saturation = saturation
        self.strokeGradient = strokeGradient
    }
    
    var body: some View {
        ZStack {
            ZStack {
                WSCustomBlurView(effect: .systemUltraThinMaterialDark) { view in
                    blurView = view
                    blurView.gaussianBlurRadius = blurRadius
                    blurView.saturationAmount = saturation
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.linearGradient(colors: [.white.opacity(0.25), .white.opacity(0.05), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .blur(radius: 5)
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(strokeGradient, lineWidth: 2)
                
            }
            .shadow(color: .black.opacity(0.15), radius: 5, x: -10, y: 10)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 10, y: -10)
            .overlay(content: {
                content
                    .padding(20)
                    .shadow(radius: 5)
//                    .blendMode(.overlay)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
        }
    }
}

fileprivate struct WSCustomBlurView: UIViewRepresentable {
    
    var effect: UIBlurEffect.Style
    var onCange: (UIVisualEffectView) -> ()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onCange(uiView)
        }
    }
}

struct WSGlassView_Previews: PreviewProvider {
    static var previews: some View {
        WSGlassView {
            VStack {
                Text("sakjdhakdsj")
                WSButtonOne(action: {
                    
                }, label: Text("Шикарная кнопка"))
            }
        }
    }
}
