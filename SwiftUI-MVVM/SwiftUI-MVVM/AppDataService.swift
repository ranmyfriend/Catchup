//
//  AppDataService.swift
//  SwiftUI-MVVM
//
//  Created by BKS-GGS on 28/09/21.
//

import Foundation

protocol DataService {
    func getUsers(completion: @escaping ([User]) -> Void)
}

/// When we are going with protocol, the viewModel is not directly coupled with AppDataService. we just have piped indirectly using DataService protocol.
class AppDataService: DataService {
    func getUsers(completion: @escaping ([User]) -> Void) {
        DispatchQueue.main.async {
            completion([
                User(id: 1, name: "Apple"),
                User(id: 2, name: "Orange"),
                User(id: 3, name: "Pineapple"),
                User(id: 4, name: "Grapes")
            ])
        }
    }
}
