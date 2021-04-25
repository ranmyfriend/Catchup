//
//  SettingsModel.swift
//  Spotify
//
//  Created by BKS-GGS on 25/04/21.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
