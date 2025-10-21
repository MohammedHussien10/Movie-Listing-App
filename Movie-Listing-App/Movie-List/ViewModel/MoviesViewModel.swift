//
//  MoviesViewModel.swift
//  Movie-Listing-App
//
//  Created by Macos on 16/09/2025.
//

import Foundation
import Combine
final class MoviesViewModel:ObservableObject {
    @Published var topRatedMovies: [Movie] = []
    @Published var allTimeMovies: [Movie] = []
    @Published var errorMessage: String?
    private let getMoviesUseCase: UseCaseMovieList
    private var cancellables = Set<AnyCancellable>()
    
    init(getMoviesUseCase: UseCaseMovieList) {
        self.getMoviesUseCase = getMoviesUseCase
    }
    
    func fetchMovies() {
        
        let top2025Moives =  getMoviesUseCase.getMovies(category: .moviesByYear(2025))
        let topAllTimeMoives =  getMoviesUseCase.getMovies(category: .topRated)
            
        Publishers.Zip(top2025Moives,topAllTimeMoives)
            .receive(on: DispatchQueue.main)
            .sink{
                completion in
                if case let .failure(error) = completion{
                    self.errorMessage = "\(error)"
                }
                
            } receiveValue : { [weak self]
                topRated,allTime in
                self?.topRatedMovies = topRated
                self?.allTimeMovies = allTime
            }.store(in:&cancellables)
    }
}
