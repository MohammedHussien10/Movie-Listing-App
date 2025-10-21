//
//  FavouritesViewModel.swift
//  Movie-Listing-App
//
//  Created by Macos on 16/10/2025.
//

import Foundation
import Combine

final class FavouritesViewModel {
    @Published private (set) var favourites: [Movie] = []
    
    private let useCaseMovieList: UseCaseMovieList
    private var cancellables = Set<AnyCancellable>()
    
    init(useCaseMovieList: UseCaseMovieList) {
        self.useCaseMovieList = useCaseMovieList
    }
    
    func getFavourites() {
        useCaseMovieList.getFavourites()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.favourites = movies
            }
            .store(in: &cancellables)
    }
    
    func addMovie(movie: Movie) {
        useCaseMovieList.addMovieToFavourites(movie: movie)
    }
    
    func removeMovie(id: Int) {
        useCaseMovieList.removeMovie(id: id)
        getFavourites()
    }
    
    func isFavourite(id: Int) -> Bool {
        return useCaseMovieList.isFavourite(id: id)
    }

 
}
