//
//  Styles.swift
//  MovieMatcher
//
//  Created by DavidR on 27/09/2021.
//

import SwiftUI

extension View{
    func defaultText() -> some View{
        modifier(DefaultText())
    }
}
extension View{
    func titleText() -> some View{
        modifier(TitleStyle())
    }
}

struct BackgroundView: View {
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [Color("BlackCoffee") , .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .edgesIgnoringSafeArea()
        Color("BlackCoffee").ignoresSafeArea()
    }
}

struct TitleStyle: ViewModifier{
    func body(content: Content) -> some View{
            content
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
}


struct DefaultText: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.system(size: 20, weight: .medium, design: .default))
            .foregroundColor(.white)
    }
}

struct TabLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .padding()
            .background(Color.yellow)
            .foregroundColor(Color.red)
    
    }
}
