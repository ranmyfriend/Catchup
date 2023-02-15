//
//  ContentViewModel.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    
    private let loginFetcher: LoginFetchable
    private var disposables = Set<AnyCancellable>()
    
    @Published var authResponse: AuthResponse?
    
    init(loginFetcher: LoginFetcher) {
        self.loginFetcher = loginFetcher
    }
    
    var signInUrlRequest: URLRequest {
        guard let url = AuthManager.shared.signInURL else {
            fatalError()
        }
        return URLRequest(url: url)
    }
    
    func fetchToken(forCode code: String) {
        loginFetcher.exchangeCodeForToken(code: code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.authResponse = nil
                case .finished: break
                }
            }, receiveValue: {[weak self] auth in
                guard let self = self else { return}
                self.authResponse = auth
            })
            .store(in: &disposables)
    }
}
