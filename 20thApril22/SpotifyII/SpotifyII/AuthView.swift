//
//  ContentView.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
   
    var body: some View {
        WebView(request: viewModel.signInUrlRequest) { code in
            viewModel.fetchToken(forCode: code)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let loginFetcher = LoginFetcher()
        let viewModel = ContentViewModel(loginFetcher: loginFetcher)
        AuthView(viewModel: viewModel)
    }
}
