//
//  ContentView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext)
    var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var currentUser: FetchedResults<User>
    
    @StateObject var viewRouter: ViewRouter
    @State var isLoggedIn: Bool = false
    var body: some View {
        GeometryReader{ geometry in
            if !isLoggedIn || currentUser.isEmpty{
                LoginView(isLoggedIn: $isLoggedIn)
            }else{
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
}

