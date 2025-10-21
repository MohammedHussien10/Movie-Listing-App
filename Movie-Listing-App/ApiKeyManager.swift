//
//  ApiKey.swift
//  Movie-Listing-App
//
//  Created by Macos on 15/09/2025.
//

import Foundation

import KeychainSwift


final class AccessTokenMovieManager{
    
    static let shared = AccessTokenMovieManager()
    private let keychain = KeychainSwift()
    private let accessTokenMovie = "AccessTokenMovieKey"
    
    private init(){
    }
    
    
    func saveAccessTokenMovie(accessToken: String){
        keychain.set(accessToken, forKey: accessTokenMovie)
    }
    
    func getAccessTokenMovie() -> String?{
        return keychain.get(accessTokenMovie)
    }
    
    
}
