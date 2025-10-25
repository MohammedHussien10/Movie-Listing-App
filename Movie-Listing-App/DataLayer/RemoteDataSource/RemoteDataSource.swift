//
//  RemoteDataSource.swift
//  Movie-Listing-App
//

//

import Foundation
import Combine
protocol RemoteDataSource{
    
    func getMovies(category:MovieCategory)-> AnyPublisher<[Movie], APIError>
    
}
