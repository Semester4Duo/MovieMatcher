//
//  GroupDTO.swift
//  MovieMatcher
//
//  Created by DavidR on 04/10/2021.
//

import SwiftUI

struct GroupDTO: Identifiable ,Codable{
    var id: Int32
    var name:String?
    var members:[UserDTO]?
}

