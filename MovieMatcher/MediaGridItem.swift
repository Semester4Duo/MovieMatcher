//
//  MediaItem.swift
//  MovieMatcher
//
//  Created by DavidR on 29/09/2021.
//

import SwiftUI

struct MediaGridItem: View {
    @State var showItemDetail: Bool = false
    
    let mediaItem : Movie
    let imgUrl = "https://image.tmdb.org/t/p/original/"
    

    var body: some View {
        ZStack{
            RemoteImage(url: (imgUrl + (mediaItem.poster ?? "")), title: mediaItem.title ?? "")
                .aspectRatio(contentMode: .fit)
                .frame(width:170,height:230)
        }.sheet(isPresented: $showItemDetail){
           ItemDetailView(mediaItem: mediaItem)
        }.onTapGesture(perform: {
            showItemDetail.toggle()
        })
    }
}

