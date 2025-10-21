//
//  Movie.swift
//  Movie-Listing-App
//
//  Created by Macos on 15/09/2025.
//

import Foundation
import Combine

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String?
    let release_date : String?
    let vote_average : Double?
    let backdrop_path: String?
    let overview: String?

    
}

struct MovieResponse: Codable {
    let results: [Movie]
}
