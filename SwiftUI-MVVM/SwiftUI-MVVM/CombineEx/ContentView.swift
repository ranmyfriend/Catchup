//
//  ContentView.swift
//  SwiftUI-MVVM
//
//  Created by BKS-GGS on 28/09/21.
//

import SwiftUI
import Combine

/*
 Author: Paul Colton
 Youtube: https://www.youtube.com/watch?v=6ZIZ5jGovEY
 */

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    var body: some View {
        VStack {
            TextField("Enter some text", text: $viewModel.myText)
                .border(Color.gray)
            Text("\(viewModel.myMessage)")
                .padding()
        }
        .padding()
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var myText: String = ""
        @Published var myMessage: String = ""
        
        init() {
            $myText
                .map { $0.isEmpty ? "👎" : "👍"}
                .assign(to: &$myMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
