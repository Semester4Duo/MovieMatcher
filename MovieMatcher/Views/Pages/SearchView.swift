//
//  SearchView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
            ZStack{
                BackgroundView()
                VStack(alignment:.leading){
                    Text("SearchView")
                        .titleText()
                    Text("Lorem ipsum dasf asdfas dfasd asdf")
                        .defaultText()
                    Spacer()
                }
            }
        
    }
}
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }
