//
//  MovieApi.swift
//  MovieMatcher
//
//  Created by DavidR on 03/10/2021.
//

import SwiftUI

struct MovieResponse: Codable{
    var results: [Movie]
}

struct Movie: Identifiable ,Codable, Hashable{
    var id: Int32
    var poster:String
    var title:String
}
struct MovieItem: Codable, Identifiable{
    var id: Int32
    var apiId: Int32
    var poster:String
    var title:String
    var overview: String
    var releaseData: Date
    var runtime: Int16
    var voteCount: Int32
    var voteAverage: Float
}




struct MovieApi_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
