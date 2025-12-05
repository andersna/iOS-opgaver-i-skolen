//
//  MovieDetailView.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    @Environment(MovieViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        HStack{
            FavoriteView(isSet: $viewModel
                .movies[viewModel.findIndexFor(movie: movie)].isFavorite)
            Text(movie.title)
                .font(.largeTitle)
        }
    }
}

#Preview {
    MovieDetailView(movie: TestData.movies[2]).environment(MovieViewModel())
}
