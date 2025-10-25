//
//  RepositoryImpl.swift
//  Movie-Listing-App
//


import Foundation
import Combine
final class RepositoryImpl: Repository{
    
    
    let remoteDataSource : RemoteDataSource
    let localDataSource : LocalDataSource
    
    init(
        remoteDataSource: RemoteDataSource,
        localDataSource : LocalDataSource
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
        
    }
    
    
    
    func getMovies(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        
        return remoteDataSource.getMovies(
                       category: category
                   )
        
    }
    
    func getFavourites() -> AnyPublisher<
        [Movie],
        Never
    > {
        localDataSource.getFavouriteMovies()
    }
    
    
    func addMovieToFavourites(
        movie: Movie
    ) {
        localDataSource.addMovieToFavourites(
            movie: movie
        )
    }
    
    
    func removeMovie(
        id: Int
    ) {
        localDataSource.removeMovie(
            id: id
        )
    }
    
    
    func isFavourite(
        id: Int
    ) -> Bool {
        localDataSource.isFavourite(
            id: id
        )
    }
    
}
