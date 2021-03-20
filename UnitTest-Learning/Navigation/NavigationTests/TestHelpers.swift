//
//  TestHelpers.swift
//  AlertTests
//
//  Created by Ranjit on 17/03/21.
//

import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

//If a unit test calls UIKit but you don't see the expected results, try executing the run loop.
func executeRunLoop() {
    RunLoop.current.run(until: Date())
}

func putInWindow(vc: UIViewController) {
    let window = UIWindow()
    window.rootViewController = vc
    window.isHidden = false
}
