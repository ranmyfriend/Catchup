//
//  TestHelpers.swift
//  ButtonTapTests
//
//  Created by Ranjit on 17/03/21.
//

import UIKit

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func tap(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}
