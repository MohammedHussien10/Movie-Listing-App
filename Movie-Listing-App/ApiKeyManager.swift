//
//  ApiKey.swift
//  Movie-Listing-App
//
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
