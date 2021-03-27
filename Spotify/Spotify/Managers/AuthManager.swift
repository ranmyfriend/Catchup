//
//  AuthManager.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientId = "4ce9a15680a542279597e9a35d56dda2"
        static let clientSecret = "421383d697074d0da919e496508eeea6"
    }
    
    private init() { }
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scope = "user-read-private"
        let redirectURI = "https://github.com/ranmyfriend"
        let string = """
        \(base)?response_type=code\
        &client_id=\(Constants.clientId)\
        &scope=\(scope)&redirect_uri=\(redirectURI)\
        &show_dialog=TRUE
        """
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func refreshAccessToken() {
        
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    private func cacheToken() {
        
    }
}
