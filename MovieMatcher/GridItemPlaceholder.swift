//
//  GridItemPlaceholder.swift
//  MovieMatcher
//
//  Created by DavidR on 30/09/2021.
//

import SwiftUI

struct GridItemPlaceholder: View {
    var body: some View {
        Rectangle()
            .frame(width:170,height:230)
            .overlay(ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(x:2, y:2, anchor: .center))
            .foregroundColor(.black)
    }
}

struct GridItemPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        GridItemPlaceholder()
    }
}
