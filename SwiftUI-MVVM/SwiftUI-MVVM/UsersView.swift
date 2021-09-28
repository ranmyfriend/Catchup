//
//  UsersView.swift
//  SwiftUI-MVVM
//
//  Created by BKS-GGS on 28/09/21.
//

import SwiftUI

/*
 Author: Kilo Loco
 Youtube: https://www.youtube.com/watch?v=bdqEcpppAMc
 */

struct UsersView: View {
    // Self.ViewModel will also works here to access the ViewModel
    @StateObject var viewModel: ViewModel
    
    /// .init() This is going initialise the viewModel. and also omit the unnecessary viewModel instance passing from outside
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
        .onAppear(perform: viewModel.getUsers)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyUser = User(id: 0, name: "Dummy")
        let viewModel = UsersView.ViewModel()
        viewModel.users = [dummyUser]
        return UsersView(viewModel: viewModel)
    }
}
