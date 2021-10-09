//
//  ItemDetailView.swift
//  MovieMatcher
//
//  Created by Dylan Nas on 24/09/2021.
//

import SwiftUI

struct ItemDetailView: View {
    let mediaItem:Movie
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var currentUser: FetchedResults<User>
    
    @State var movie: MovieItemResponse = MovieItemResponse.init(result: MovieItem(id: 0, apiId: 0, poster: "", title: "", overview: "", releaseDate: "", runtime: 0, voteCount: 0, voteAverage: 0))
    let imgUrl = "https://image.tmdb.org/t/p/original/"
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack(alignment: .leading){
                    ZStack{
                        RemoteImage(url: imgUrl + movie.result.poster, title: movie.result.title)
                            .aspectRatio(contentMode: .fit)
                        VStack{
                            VStack{
                                
                                Text(movie.result.title)
                                    .foregroundColor(Color.white)
                                    .titleText()
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.leading, 20)
                                    .padding(.top,5)
                                Text(movie.result.releaseDate.components(separatedBy: "T")[0])
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom,5)
                            }
                            .background(.ultraThinMaterial)
                            Spacer()
                            HStack{
                                Image(systemName: "rectangle.stack.fill.badge.person.crop")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(.trailing, 20)
                                    .onTapGesture(perform: makeWatched)
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(.leading, 20)
                                    .onTapGesture(perform: makeMatch)
                            }.padding(.bottom, 40)
                        }
                    }
                    HStack{
                        Text("Description").titleText().padding(.leading, 20)
                        Spacer()
                        ZStack{
                            Circle().fill(Color("BlackTP")).frame(width: 60, height: 60)
                            Text(String(format: "%.1f",movie.result.voteAverage).replacingOccurrences(of: ".", with: "")+"%")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        Text("Userscore")
                            .padding(.trailing, 40)
                            .foregroundColor(Color.white)
                    }
                    Text(movie.result.overview)
                        .foregroundColor(Color("WhiteTP"))
                        .frame(width: geometry.size.width-40)
                        .padding(.leading, 20)
                }
            }.background(Color("BlackCoffee"))
        }
        .preferredColorScheme(.dark).onAppear{
            getMovie()
        }
    }
    
    func getMovie(){
        guard let url = URL(string: "https://moviematcher.kurza.nl/item/movie/\(mediaItem.id)") else{
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("new request")
                if let decodedResponse = try? JSONDecoder().decode(MovieItem.self, from: data) {
                    print(decodedResponse)
                    DispatchQueue.main.async {
                        // update our UI
                        movie = MovieItemResponse(result: decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
    
    func makeMatch(){
        let session = URLSession.shared
        let url = URL(string: "https://moviematcher.kurza.nl/match/movie/")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let json = [
            "userId": currentUser[0].id,
            "movieId": mediaItem.id
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            // Do something...
        }
        
        task.resume()
    }
    
    func makeWatched(){
        let session = URLSession.shared
        let url = URL(string: "https://moviematcher.kurza.nl/watch/movie/")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let json = [
            "userId": currentUser[0].id,
            "movieId": mediaItem.id
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            // Do something...
        }
        
        task.resume()
    }
}

struct MovieDetailView: View {
    let mediaItem:MovieItem
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear{getMovies(page: 1)}
    }
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    var currentUser: FetchedResults<User>
    
    init(mediaItem: MovieItem) {
        self.mediaItem = mediaItem
        let session = URLSession.shared
        let url = URL(string: "https://moviematcher.kurza.nl/match/movie/")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let json = [
            "userId": 3,
            "movieId": mediaItem.id
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            // Do something...
        }
        
        task.resume()
    }
    
    @State var movie: MovieItemResponse = MovieItemResponse.init(result: MovieItem(id: 0, apiId: 0, poster: "", title: "", overview: "", releaseDate: "", runtime: 0, voteCount: 0, voteAverage: 0))
    
    func getMovies(page:Int16){
        guard let url = URL(string: "https://moviematcher.kurza.nl/item/movie/\(mediaItem.id)") else{
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
                if let decodedResponse = try? JSONDecoder().decode(MovieItem.self, from: data) {
                    print(decodedResponse)
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        movie = MovieItemResponse(result: decodedResponse)
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

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack(alignment: .leading){
                    ZStack{
                        Image("walle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
        
            
                        VStack{
                            VStack{
                                
                                Text("Wall-e")
                                    .foregroundColor(Color.white)
                                    .titleText()
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.leading, 20)
                                    .padding(.top,5)
                                Text("datum troep")
                                    .frame(width: geometry.size.width, alignment: .leading)
                                    .padding(.leading, 20)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom,5)
                            }
                            .background(.ultraThinMaterial)
                            Spacer()
                            HStack{
                                Image(systemName: "rectangle.stack.fill.badge.person.crop")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(.trailing, 20)
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40)
                                    .padding(.leading, 20)
                            }.padding(.bottom, 40)
                        }
                        .foregroundColor(.white)
                    }
                    HStack{
                        Text("Description").titleText().padding(.leading, 20)
                        Spacer()
                        ZStack{
                            Circle().fill(Color("BlackTP")).frame(width: 60, height: 60)
                            Text("80%").foregroundColor(Color.white).fontWeight(.bold)
                        }
                        Text("Userscore")
                            .padding(.trailing, 40)
                            .foregroundColor(Color.white)
                    }
                    Text("Lorem ipsum alles d d d d dd d dd d d d dd dd d d d d d dd ddskdfjaldsh daksfh klasfh asdhfkh jsasfaskdfh hlaskdf hhasdkfh kasfhf aksfhkasdhf ksdahf asjdfh k")
                        .foregroundColor(Color("WhiteTP"))
                        .frame(width: geometry.size.width-40)
                        .padding(.leading, 20)
                }
            }.background(Color("BlackCoffee"))
        }
        .preferredColorScheme(.dark)
    }
}
