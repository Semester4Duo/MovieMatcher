//
//  UserDTO.swift
//  MovieMatcher
//
//  Created by DavidR on 04/10/2021.
//

import SwiftUI

struct UserDTO: Identifiable ,Codable{
    var id: Int32
    var groups:[GroupDTO]?
    var email:String
    var seriesMatches:String?
    var movieMatches:[MovieMatch]?
}
