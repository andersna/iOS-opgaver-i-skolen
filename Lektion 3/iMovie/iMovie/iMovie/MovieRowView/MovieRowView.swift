//
//  MovieRowView.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

struct MovieRowView: View {
    var movie: Movie

    var body: some View {
        HStack(spacing: 24){
                ImageRowView(poster: movie.poster)
            }
            SideInfoView(
                title: movie.title,
                director: movie.director,
                genre: movie.genre,
                runtime: movie.runtime,
                isFavorite: movie.isFavorite)
        }
    }

#Preview(traits: .sizeThatFitsLayout) {
    MovieRowView(movie: TestData.movies[0])
}

