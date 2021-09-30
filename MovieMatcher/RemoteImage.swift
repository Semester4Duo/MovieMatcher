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
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
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

    @StateObject private var loader: Loader
    var loading: Rectangle
    var failure: Rectangle

    @ViewBuilder
    var body: some View {
        selectImage()
    }

    init(url: String, title: String, loading: Rectangle = Rectangle(),
         failure: Rectangle = Rectangle()) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    @ViewBuilder
    private func selectImage() -> some View {
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
                 Image(uiImage: image)
                    .resizable()
            } else {
                 failure
            }
        }
    }
}
