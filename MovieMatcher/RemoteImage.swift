//
//  RemoteImage.swift
//  MovieMatcher
//
//  Created by DavidR on 29/09/2021.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    
    private class Loader: ObservableObject {
        @FetchRequest(entity: User.entity(), sortDescriptors: [])
        var currentUser: FetchedResults<User>
        
        @Published var data = Data()
        var state = LoadState.loading
        
        init(url: String) {
            print(currentUser.first)
            print(url)
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    
    @ObservedObject private var loader: Loader
    var loading: Rectangle
    var failure: Rectangle
    
    var body: some View {
        switch loader.state {
        case .loading:
            ZStack{
                GridItemPlaceholder()
            }
        case .failure:
            ZStack{
                GridItemPlaceholder()
            }
        default:
            if let image = UIImage(data: loader.data) {
                ZStack{
                    Image(uiImage: image)
                        .resizable()
                }
            } else {
                failure
            }
        }
    }
    
    
    init(url: String, title: String, loading: Rectangle = Rectangle(),
         failure: Rectangle = Rectangle()) {
        _loader = ObservedObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
}









//}
//struct RemoteImage: View {
//    var url:String
//    @State private var status:LoadState = .loading
//    @State private var data:Data = Data()
//
//    private enum LoadState {
//        case loading, success, failure
//    }
//
//    @ViewBuilder
//    var body: some View {
//        ZStack{
//            switch status {
//            case .loading:
//                ZStack{
//                    GridItemPlaceholder()
//                }
//            case .failure:
//                ZStack{
//                    GridItemPlaceholder()
//                }
//            default:
//                if let image = UIImage(data: data) {
//                    ZStack{
//                     Image(uiImage: image)
//                        .resizable()
//                    }
//                } else {
//                    status = .failure
//                }
//            }
//        }.onAppear(perform: loadImage())
//    }
//
//    func loadImage(){
//                   guard let parsedURL = URL(string: url) else {
//                       fatalError("Invalid URL: \(url)")
//                   }
//
//                   URLSession.shared.dataTask(with: parsedURL) { data, response, error in
//                       if let data = data, data.count > 0 {
//                           data = data
//                           status = .success
//                       } else {
//                           status = .failure
//                       }
//
//                       DispatchQueue.main.async {
//
//                       }
//                   }.resume()
//    }
//}


