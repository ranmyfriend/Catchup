//
//  LoginFetcher.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation
import Combine

protocol LoginFetchable {
   func exchangeCodeForToken(code: String) -> AnyPublisher<AuthResponse, LoginError>
}

class AuthFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension AuthFetcher {
    struct Constants {
        private static let bundleInfo = Bundle.main.infoDictionary
        
        static var clientId: String {
            guard let key = bundleInfo?["clientId"] as? String else {
                fatalError("clientId not found")
            }
            return key
        }
        static var clientSecret: String {
            guard let key = bundleInfo?["clientSecret"] as? String else {
                fatalError("clientSecret not found")
            }
            return key
        }
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://github.com/ranmyfriend"
        static let scopes = """
                                user-read-private\
                                %20playlist-modify-public\
                                %20playlist-read-private\
                                %20playlist-modify-private\
                                %20user-follow-read\
                                %20user-follow-modify\
                                %20user-library-read\
                                %20user-read-email\
                                %20user-library-modify
                                """
    }
    
    func makeExchangeCodeRequest(code: String) -> URLRequest? {
        //         Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return nil
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI)
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)

        let basicToken = Constants.clientId + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            return nil
        }

        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        return request
        
//        URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
//            guard let data = data, error == nil else {
//                return completion(false)
//            }
//
//            do {
//                let result = try JSONDecoder().decode(AuthResponse.self, from: data )
//                self?.cacheToken(result: result)
//                completion(true)
//            } catch {
//                print("Error:\(error.localizedDescription)")
//                completion(false)
//            }
//        }.resume()
    }
}


extension AuthFetcher: LoginFetchable {
    func exchangeCodeForToken(code: String) -> AnyPublisher<AuthResponse, LoginError> {
        exchange(with: makeExchangeCodeRequest(code: code))
    }
    
    private func exchange<T>(with request: URLRequest?) -> AnyPublisher<T, LoginError> where T: Decodable {
        guard let urlRequest = request else {
            let error = LoginError.network(description: "Couldn't create URL")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                LoginError.network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}
