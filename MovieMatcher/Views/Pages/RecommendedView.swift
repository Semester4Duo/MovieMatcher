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
    
    @State var movies: MovieResponse = MovieResponse.init(results: [])
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var Dictonary: NSMutableDictionary = NSMutableDictionary()
    var body: some View {
        ZStack{
            BackgroundView()
            ScrollView(){
                RecommendedHeaderView()
                LazyVGrid(columns: columns, spacing: 12){
                    
                    ForEach(movies.results, id: \.self){ movie in
                        MediaGridItem(mediaItem: movie)
                    }
                }
                .padding()
            }
        }.onAppear{getMovies(page: 1)}
    }
    
    func getMovies(page:Int16){
        guard let url = URL(string: "https://moviematcher.kurza.nl/discover/movie/1") else{
            print("Invalid URL")
            return
        }
        
//        URLSession.shared.dataTask(with: url) { data, _, _ in
//            let movie = try! JSONDecoder().decode([Movie].self, from: data!)
//        }
//        .resume()
//
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("new request")
                if let decodedResponse = try? JSONDecoder().decode([Movie].self, from: data) {
                    print(data)
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        movies.results = decodedResponse
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedView()
//    }
//}

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
