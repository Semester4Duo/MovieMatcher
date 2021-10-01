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
extension View{
    func inputStyle() -> some View{
        modifier(InputStyle())
    }
}

extension View{
    func buttonStyle() -> some View{
        modifier(ButtonStyle())
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

struct InputStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 15)
            .padding(.bottom,10)
    }
}

struct ButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        content
            .background(LinearGradient(gradient: Gradient(colors: [Color("Purple1"), Color("Purple2")]), startPoint: .top, endPoint: .bottom))
            .clipShape(Capsule(), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
            .padding(.bottom,5)
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

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color("InputField"))
            .cornerRadius(20)
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View{
        
        ZStack(alignment: alignment){
            self
            placeholder().opacity(shouldShow ? 1 : 0)
        }
    }
}
