//
//  MatchView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct MatchView: View {
    @Environment(\.managedObjectContext)
    var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var currentUser: FetchedResults<User>
    
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
        guard let url = URL(string: "https://moviematcher.kurza.nl/match/movie?userId=3") else{
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
                print(String(decoding: data, as: UTF8.self))
                if let decodedResponse = try? JSONDecoder().decode([MovieMatch].self, from: data) {
                    print(data)
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        var converted:[Movie] = []
                        
                        for match in decodedResponse {
                            converted.append(Movie(id: match.movie.id, poster: match.movie.poster, title: match.movie.title))
                        }
                        
                        movies.results = converted
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
