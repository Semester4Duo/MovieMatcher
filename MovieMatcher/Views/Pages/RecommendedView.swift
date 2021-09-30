//
//  SwiftUIView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct RecommendedView: View {
    @Environment(\.managedObjectContext)
    var moc
    @State var runOnce: Bool = true
    
    @FetchRequest(entity: MediaItem.entity(), sortDescriptors: [])
    var mediaItems: FetchedResults<MediaItem>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack{
            BackgroundView()
            ScrollView(){
                RecommendedHeaderView()
                LazyVGrid(columns: columns, spacing: 12){
                    
                    ForEach(mediaItems, id: \.self){ mediaItem in
                        MediaGridItem(mediaItem: mediaItem)
                    }
//                    if(mediaItems.count < 6){
//                        ForEach(0..<(6-mediaItems.count)){value in
//                            GridItemPlaceholder()
//                        }
//                    }
                }
                .padding()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedView()
    }
}

struct RecommendedHeaderView: View {
    var body: some View {
        HStack{
            Text("Recommended").titleText()
            Spacer()
            Image(systemName: "square.grid.2x2.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
                .padding(.trailing)
            Image(systemName: "ticket.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
