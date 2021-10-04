//
//  TabBar.swift
//  MovieMatcher
//
//  Created by DavidR on 28/09/2021.
//

import SwiftUI

struct TabView: View {
    @StateObject var viewRouter: ViewRouter
    let geometry: GeometryProxy
    
    var body: some View {
        HStack{
            TabViewIcon(viewRouter:viewRouter, assignedPage: .search, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "magnifyingglass", tabName: "Search")
            TabViewIcon(viewRouter:viewRouter, assignedPage: .recommended, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "star.fill", tabName: "Nominations")
            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                    .shadow(radius: 4)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
                    .foregroundColor(Color.purple)
            }
            .offset(y: -geometry.size.height/28)
            
            TabViewIcon(viewRouter:viewRouter, assignedPage: .matches, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "heart.fill", tabName: "Matches")
            TabViewIcon(viewRouter:viewRouter, assignedPage: .watched, width: geometry.size.width/5, height: geometry.size.height/28, systemIconName: "rectangle.stack.fill.badge.play.crop.fill", tabName: "Watched")
        }
        .frame(width: geometry.size.width, height: geometry.size.height/8)
        .background(Color.black)
    }
}

struct TabViewIcon: View {
    @StateObject var viewRouter: ViewRouter
    
    let assignedPage: Page
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //Since we have five icons, we want everyone to be one-fifth of the ContentView's width
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture{
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .white : .gray)
    }
}
