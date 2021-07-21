//
//  UserProfile.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let displayName: String
    let email: String
    let explicitContent: [String: Bool]
//    let externalUrls: [String: String]
//    let followers:  [String: Codable?]
//    let href: String
    let id: String
    let images: [APIImage]
    let product: String
    
}

extension UserProfile {
    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
//        case externalUrls = "external_urls"
//        case href
        case id
        case images
        case product
    }
}

