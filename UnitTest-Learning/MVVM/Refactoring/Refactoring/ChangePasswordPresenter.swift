//
//  ChangePasswordPresenter.swift
//  Refactoring
//
//  Created by BKS-GGS on 06/04/21.
//

import Foundation

//MVP(DESIGN PATTERN):
// MODEL - VIEW - PRESENTER(holds View and ViewModel)
//MVVM(DESIGN PATTERN):
// MODEL - VIEW - VIEWMODEL(Directly view model communicate the view based on the logic change)

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    private var viewModel: ChangePasswordViewModel
    
    init(view: ChangePasswordViewCommands, viewModel: ChangePasswordViewModel) {
        self.view = view
        self.viewModel = viewModel
    }
    
}
