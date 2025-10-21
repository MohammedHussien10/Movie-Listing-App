//
//  LocalDataSourceImpl.swift
//  Movie-Listing-App
//
//  Created by Macos on 16/10/2025.
//

import Foundation
import Combine
import CoreData
final class LocalDataSourceImpl:LocalDataSource{
    
    
    
    private let db = DataBaseManager.shared
    
    func getFavouriteMovies() -> AnyPublisher<[Movie], Never> {
        let movies = db.fetchFavourites()
        return Just(movies).eraseToAnyPublisher()
    }
    
    func addMovieToFavourites(movie: Movie) {
        db.addMovieToFavourites(
            id: movie.id,
            title: movie.title,
            posterPath: movie.poster_path ?? "",
            releaseDate: movie.release_date ?? "",
            voteAverage: movie.vote_average ?? 0.0,
            backdropPath: movie.backdrop_path ?? "",
            overView: movie.overview ?? ""
        )
    }
    
    func removeMovie(id: Int) {
        db.removeMovie(id: id)
    }
    
    func isFavourite(id: Int) -> Bool {
        return db.isFavourite(id: id)
    }
    
    func saveMovies(_ movies: [Movie], for category: MovieCategory) {
        db.saveMovies(movies, for: category)
    }
    
    func getMoviesLocal(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        return db.getMoviesLocal(category: category)
    }
}
