//
//  UseCaseMovieList.swift
//  Movie-Listing-App
//
//

import Foundation
import Combine

protocol UseCaseMovieList{
    func getMovies(category: MovieCategory)-> AnyPublisher<[Movie], APIError>
    func getFavourites() -> AnyPublisher<[Movie], Never>
    func addMovieToFavourites(movie: Movie)
    func removeMovie(id: Int)
    func isFavourite(id: Int) -> Bool
}
