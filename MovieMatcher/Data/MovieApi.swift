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

struct MovieItemResponse: Codable{
    var result: MovieItem
}

struct MovieMatch: Identifiable ,Codable {
    var id: Int32
    var user: UserDTO
    var group: GroupDTO?
    var movie: MovieItem
    var matched: Bool
    var watched: Bool
}

struct Movie: Identifiable ,Codable, Hashable{
    var id: Int32
    var poster:String
    var title:String
}
struct MovieItem: Codable, Identifiable{
    var id: Int32
    var genres: String?
    var apiId: Int32
    var poster:String
    var title:String
    var overview: String
    var releaseDate: String
    var runtime: Int16
    var voteCount: Int32
    var voteAverage: Float
}




struct MovieApi_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
