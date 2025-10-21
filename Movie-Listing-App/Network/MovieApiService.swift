
//  Movie-Listing-App
//
//  Created by Macos on 15/09/2025.
//

import Foundation
import Combine
import KeychainSwift



protocol MovieApiServiceProtocol {
    func request<T:Codable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, APIError>
}

final class MovieApiService:MovieApiServiceProtocol {
    
    private let keychain = KeychainSwift()
    
    static let shared = MovieApiService()
    
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T:Codable>(_ endpoint: String, responseType: T.Type) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(endpoint)") else {
                   return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
               }
               
               guard let token = keychain.get("AccessTokenMovieKey") else {
                   return Fail(error: APIError.missingToken).eraseToAnyPublisher()
               }
               
               var request = URLRequest(url: url)
               request.httpMethod = "GET"
               request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
               request.setValue("application/json", forHTTPHeaderField: "accept")
        
        return session.dataTaskPublisher(for: request).mapError{APIError.urlSessionError($0)}
            .flatMap{data,response -> AnyPublisher<T,APIError> in

                
                
            guard let httpResponse = response as? HTTPURLResponse else {
                return Fail(error: APIError.httpError(-1)).eraseToAnyPublisher()
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                return Fail(error: APIError.httpError(httpResponse.statusCode)).eraseToAnyPublisher()
            }
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error in
                    if error is DecodingError {
                        return .decodingError
                    } else {
                        return .unknown(error)
                    }
                }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
        }
        
        
    }

    


enum APIError: Error {
    case invalidURL
    case httpError(Int)
    case decodingError
    case urlSessionError(Error)
    case unknown(Error)
    case missingToken
}

