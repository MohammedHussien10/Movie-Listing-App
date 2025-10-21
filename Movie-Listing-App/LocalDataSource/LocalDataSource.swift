//
//  LocalDataSource.swift
//  Movie-Listing-App
//
//  Created by Macos on 16/10/2025.
//

import Foundation
import Combine
protocol LocalDataSource {
    func saveMovies(_ movies: [Movie], for category: MovieCategory)
    func getMoviesLocal(category:MovieCategory)-> AnyPublisher<[Movie], APIError>
    func getFavouriteMovies() -> AnyPublisher<[Movie], Never>
    func addMovieToFavourites(movie: Movie)
    func removeMovie(id: Int)
    func isFavourite(id: Int) -> Bool
}
