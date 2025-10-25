//
//  UseCases.swift
//  Movie-Listing-App


import Foundation
import Combine
final class UseCaseMovieListImpl:UseCaseMovieList{
    
    let repo : Repository
    
    init(repo: Repository) {
        self.repo = repo
    }
    

    
    func getMovies(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        return repo.getMovies(category: category)
    }
    
        
    func getFavourites() -> AnyPublisher<[Movie], Never> {
        return repo.getFavourites()
       }
    
    func addMovieToFavourites(movie: Movie) {
        repo.addMovieToFavourites(movie: movie)
    }
    
    func removeMovie(id: Int) {
        repo.removeMovie(id: id)
    }
    
    func isFavourite(id: Int) -> Bool {
        repo.isFavourite(id: id)
    }
}
