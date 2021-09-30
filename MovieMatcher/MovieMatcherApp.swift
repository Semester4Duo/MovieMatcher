//
//  MovieMatcherApp.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

@main
struct MovieMatcherApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environment(\.managedObjectContext,
                    persistenceContainer.container.viewContext)
        }
    }
}
