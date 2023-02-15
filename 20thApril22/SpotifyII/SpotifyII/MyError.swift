//
//  LoginError.swift
//  SpotifyII
//
//  Created by BKS-GGS on 20/04/22.
//

import Foundation

enum MyError: Error {
    case parsing(description: String)
    case network(description: String)
}
