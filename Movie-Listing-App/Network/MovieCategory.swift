//
//  MovieCategory.swift
//  Movie-Listing-App
//
//

import Foundation

enum MovieCategory{
    
    case topRated
    case moviesByYear(Int)
    
    var endPoint:String{
      
    switch self {
    case .topRated:
         return "movie/top_rated"
        
    case .moviesByYear(let year):
         return "discover/movie?primary_release_year=2025&sort_by=vote_average.desc&vote_count.gte=100"
            
            
        }
        
    }
    
    
}
