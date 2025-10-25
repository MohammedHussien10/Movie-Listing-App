//
//  RemoteDataSourceImpl.swift
//  Movie-Listing-App
//
//

import Foundation
import Combine
class RemoteDataSourceImpl:RemoteDataSource{

    
    let apiService : MovieApiService
    
    init(apiService: MovieApiService = MovieApiService.shared) {
        self.apiService = apiService
    }
    
    func getMovies(category: MovieCategory) -> AnyPublisher<[Movie], APIError> {
        return apiService.request(category.endPoint, responseType: MovieResponse.self)
                         .map { $0.results }
                         .eraseToAnyPublisher()
    }
    

}
