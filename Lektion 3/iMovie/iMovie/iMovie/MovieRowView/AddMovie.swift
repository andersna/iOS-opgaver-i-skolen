//
//  AddMovie.swift
//  iMovie
//
//  Created by dmu mac 29 on 11/09/2025.
//

import SwiftUI

struct AddMovie: View {
    @Environment(MovieViewModel.self) private var viewModel
    @Binding var showingAddMovieSheet: Bool
    @State private var title: String = ""
    @State private var year: Int = 2025
    @State private var runtime: String = ""
    @State private var genre: String = ""
    @State private var director: String = ""
    @State private var actors: String = ""
    @State private var plot: String = ""
    @State private var country: String = ""
    @State private var awards: String = ""
    @State private var poster: String = ""
    @State private var rating: String = ""
    @FocusState private var movieNameFocusState: Bool
    
    
    var body: some View {
        let years = Array(1900...2100)
        Form{
            Section("Data"){
                TextField("movie title", text: $title).focused($movieNameFocusState)
                Picker("year", selection: $year){
                    ForEach(years, id:\.self){
                        year in Text(String(year)).tag(year)
                    }
                }
                TextField("runtime", text: $runtime)
                TextField("genre", text: $genre)
                TextField("director", text: $director)
                TextField("actors", text: $actors)
                TextField("plot", text: $plot)
                TextField("country", text: $country)
                TextField("awards", text: $awards)
                TextField("poster", text: $poster)
                TextField("rating", text: $rating)
            }
            Button("Add Movie") {
                let newMovie = Movie(title: title, year: String(year), runtime: runtime, genre: genre, director: director, actors: actors, plot: plot, country: country, awards: awards, poster: poster, rating: rating)
                viewModel.add(movie: newMovie)
                showingAddMovieSheet = false
            }
        }.onAppear(){
            movieNameFocusState = true
        }
    }
}

#Preview {
    @Previewable @State var x = true
    AddMovie(showingAddMovieSheet: $x)
        .environment(MovieViewModel())
}
