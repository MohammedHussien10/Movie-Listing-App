//
//  NetworkManger.swift
//  Movie-Listing-App
//
//  Created by Macos on 15/09/2025.
//

import Foundation
import Combine
import KeychainSwift



protocol NetworkManagerProtocol {
    func request<T:Codable> (ـ endpoint: String,responseType:T.Type ) -> AnyPublisher<T,APIError>
    
}

final class NetworkManager:NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(ـ endpoint: String, responseType: T.Type) -> AnyPublisher<T, APIError> {
        
        guard let url = URL(string: "https://api.themoviedb.org/3\(endpoint)?api_key=\(ke.apiKey)") else{
            
        }
    }

    
}

enum APIError: Error {
    case invalidURL
    case httpError(Int)
    case decodingError
    case urlSessionError(Error)
    case unknown(Error)
}

/*
 
 final class NetworkManager: NetworkManagerProtocol {
 
 static let shared = NetworkManager()
 private let session: URLSession
 
 private init(session: URLSession = .shared) {
 self.session = session
 }
 
 func request<T: Decodable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, APIError> {
 
 // build URL
 guard let url = URL(string: "https://api.themoviedb.org/3\(endpoint)?api_key=\(Constants.apiKey)") else {
 return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
 }
 
 var request = URLRequest(url: url)
 request.httpMethod = "GET"
 
 return session.dataTaskPublisher(for: request)
 .tryMap { data, response -> Data in
 guard let httpResponse = response as? HTTPURLResponse,
 200..<300 ~= httpResponse.statusCode else {
 throw APIError.httpError((response as? HTTPURLResponse)?.statusCode ?? -1)
 }
 return data
 }
 .decode(type: T.self, decoder: JSONDecoder())
 .mapError { error -> APIError in
 if error is DecodingError { return .decodingError }
 if let apiError = error as? APIError { return apiError }
 return .unknown(error)
 }
 .receive(on: DispatchQueue.main)
 .eraseToAnyPublisher()
 }
 }
 */
