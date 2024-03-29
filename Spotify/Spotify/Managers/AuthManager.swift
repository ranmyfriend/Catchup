//
//  AuthManager.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    /// when refreshing the token in in progress by the help of this token, we will get to know.
    private var refreshingToken = false
    
    struct Constants {
        static let clientId = "4ce9a15680a542279597e9a35d56dda2"
        static let clientSecret = "421383d697074d0da919e496508eeea6"
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
    
    private init() { }
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let string = """
                            \(base)\
                            ?response_type=code\
                            &client_id=\(Constants.clientId)\
                            &scope=\(Constants.scopes)\
                            &redirect_uri=\(Constants.redirectURI)\
                            &show_dialog=TRUE
                            """
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiresIn") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    /// Supplies valid token to be used with api calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            // Refresh
            refreshIfNeeded { [weak self] (success) in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
  //completionHandler is not mandatory thats why we made it as optional
    public func refreshIfNeeded(completion: ((Bool) -> Void)?) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
          completion?(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        // Refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientId + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
              completion?(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach {$0(result.accessToken)}
                self?.onRefreshBlocks.removeAll()
                print("Successfully refreshed token")
                self?.cacheToken(result: result)
                completion?(true)
            } catch {
                print("Error:\(error.localizedDescription)")
                completion?(false)
            }
        }.resume()
        
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        // Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
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
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                return completion(false)
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data )
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print("Error:\(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "accessToken")
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        }
        let expiresIn = Date().addingTimeInterval(TimeInterval(result.expiresIn))
        UserDefaults.standard.setValue(expiresIn, forKey: "expiresIn")
    }
  
  public func signout(completion: (Bool) -> Void) {
    UserDefaults.standard.setValue(nil, forKey: "accessToken")
    UserDefaults.standard.setValue(nil, forKey: "refreshToken")
    UserDefaults.standard.setValue(nil, forKey: "expiresIn")
    completion(true)
  }
}
