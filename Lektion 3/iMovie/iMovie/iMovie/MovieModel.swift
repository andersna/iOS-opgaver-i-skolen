//
//  MovieModel.swift
//  iMovie
//
//  Created by dmu mac 29 on 26/08/2025.
//

import Foundation

struct Movie: Identifiable, Hashable, Codable {
    let id = UUID()
    let title: String
    let year: String
    let runtime: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    let country: String
    let awards: String
    let poster: String
    let rating: String?
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title, year, runtime, genre, director, actors, plot, country, awards, poster, rating
    }
}

@Observable
class MovieViewModel {
    var movies: [Movie] = TestData.movies
    var favoriteMovies: [Movie] {
        movies.filter{$0.isFavorite}
    }
    
    func findIndexFor(movie: Movie) -> Int {
        return movies.firstIndex{
            originalMovie in originalMovie.id == movie.id
        }!
    }
    
    func move(from source: IndexSet, to destination: Int ){
        movies.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleFavorite(movie: Movie){
        let index = findIndexFor(movie: movie)
        movies[index].isFavorite.toggle()
    }
    
    func delete(movie: Movie){
        let index = findIndexFor(movie: movie)
        movies.remove(at: index)
    }
    
    func add(movie: Movie){
        movies.append(movie)
    }

}

struct TestData{
    static var movies: [Movie] = {
        let url = Bundle.main.url(forResource: "Movies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode([Movie].self, from: data)    }()
}
