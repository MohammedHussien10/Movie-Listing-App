//
//  ApiKey.swift
//  Movie-Listing-App
//
//  Created by Macos on 15/09/2025.
//

import Foundation

import KeychainSwift


final class ApiKeyManager{
    
    static let shared = ApiKeyManager()
    private let keychain = KeychainSwift()
    private let movieApiKey = "MoviesApiKey"
    
    private init(){
    }
    
    
    func setKey(apiKey: String){
        keychain.set(apiKey, forKey: movieApiKey)
    }
    
    func getKey() -> String?{
        return keychain.get(movieApiKey)
    }
    
    
}
