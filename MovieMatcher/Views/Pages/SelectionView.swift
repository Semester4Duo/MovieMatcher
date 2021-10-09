//
//  SelectionView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct SelectionView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            ScrollView{
                HStack{
                    ZStack{
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .padding()
                            .foregroundColor(Color.init(UIColor(white: 1, alpha: 0)))
                            .cornerRadius(100)
                            .padding(2)
                            .background(Color.blue)
                            .cornerRadius(100)
                        Image("Profile")
                            .hueRotation(Angle.degrees(600))
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .cornerRadius(100)
                    }
                }
            }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
