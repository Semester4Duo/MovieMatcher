//
//  ContentView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                switch viewRouter.currentPage {
                case .search:
                    SearchView()
                case .recommended:
                    RecommendedView()
                case .account:
                    Text("account")
                case .matches:
                    MatchView()
                case .watched:
                    WatchedView()
                }
                Spacer()
                
                TabView(viewRouter: viewRouter, geometry: geometry)
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter()).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

