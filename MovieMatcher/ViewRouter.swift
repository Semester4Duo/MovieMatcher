//
//  ViewRouter.swift
//  MovieMatcher
//
//  Created by DavidR on 28/09/2021.
//

import SwiftUI


class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .search
}

enum Page {
     case search
     case recommended
     case account
     case matches
     case watched
 }
