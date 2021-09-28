//
//  UsersViewModel.swift
//  SwiftUI-MVVM
//
//  Created by BKS-GGS on 28/09/21.
//

import Foundation

/// The way I create ViewModel inside the View extension because one view should have one unique viewModel. sometime other views also get interacted the viewModel. Kilo Loco(Author) does not find any suitable reason for this.
extension UsersView {
    class ViewModel: ObservableObject {
        @Published var users = [User]()
        let dataService: DataService
        
        // In some cases AppDataService shared object may pass through
        init(dataService: DataService = AppDataService()) {
            self.dataService = dataService
        }
        
        func getUsers() {
            dataService.getUsers { [weak self] users in
                self?.users = users
            }
        }
    }
}
