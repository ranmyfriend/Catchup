//
//  ChangePasswordViewModel.swift
//  Refactoring
//
//  Created by BKS-GGS on 05/04/21.
//

import Foundation

/*
“When a view model property changes, we need a way for the view controller to use the new value. We can do this in various ways, from Apple’s Key-Value Observing to third-party frameworks like Reactive Swift. For our example, we’ll use a simple way built into the Swift language: the didSet observer.”
*/

struct ChangePasswordViewModel {

    var isCancelButtonEnabled = true
    
}
