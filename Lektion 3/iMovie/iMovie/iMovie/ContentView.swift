//
//  ContentView.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(MovieViewModel.self) private var viewModel
    @State private var navigationPath: [Movie] = []
    @State private var showingAddMovieSheet = false
    @State private var showingDeleteMovieConfirmationDialog = false
    @State private var selectedMovie: Movie?
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List{
                ForEach(viewModel.movies) { movie in
                    NavigationLink(value: movie){
                        MovieRowView(movie: movie)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive){
                            withAnimation{
                                selectedMovie = movie
                                showingDeleteMovieConfirmationDialog = true
                            }
                        }label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button(){
                            viewModel.toggleFavorite(movie: movie)
                        }label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.green)
                    }
                }.onMove(perform: viewModel.move)
            }
            .navigationTitle("MovieList")
            .sheet(isPresented: $showingAddMovieSheet) {
                AddMovie(showingAddMovieSheet: $showingAddMovieSheet)
                    .presentationDetents([.large])
            }
            .confirmationDialog("Delete movie?", isPresented: $showingDeleteMovieConfirmationDialog, titleVisibility: .visible, actions: {
                Button("Delete", role: .destructive){
                    if let movie = selectedMovie{
                        viewModel.delete(movie: movie)
                        selectedMovie = nil
                    }
                }
            })
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddMovieSheet = true
                    } label: {
                        Label("Opret", systemImage: "plus.circle")
                            .labelStyle(.iconOnly)
                            .font(.largeTitle)
                    }
                }
            }
            .navigationDestination(for: Movie.self) { theMovie in
                MovieDetailView(movie: theMovie)
            }
        }
    }
}

#Preview {
    ContentView().environment(MovieViewModel())
}
