//
//  ContentView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            RecommendedView().tabItem {
                Label("Recommended", systemImage: "star.fill")
            }
            SelectionView().tabItem {
                Label("", systemImage: "list.dash")
            }
            MatchView().tabItem {
                Label("Matches", systemImage: "heart.fill")
            }
            WatchedView().tabItem {
                Label("Watched", image: "rectangle.stack.fill.badge.play.crop.fill")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
