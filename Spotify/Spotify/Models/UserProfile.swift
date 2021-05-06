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
    let images: [UserImage]
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

struct UserImage: Codable {
//    let height: String
    let url: String
//    let width: String
}

/*
{
    country = IN;
    "display_name" = ranjith2010;
    email = "ranjithmedzin@gmail.com";
    "explicit_content" =     {
        "filter_enabled" = 0;
        "filter_locked" = 0;
    };
    "external_urls" =     {
        spotify = "https://open.spotify.com/user/ranjith2010";
    };
    followers =     {
        href = "<null>";
        total = 0;
    };
    href = "https://api.spotify.com/v1/users/ranjith2010";
    id = ranjith2010;
    images =     (
                {
            height = "<null>";
            url = "https://i.scdn.co/image/ab6775700000ee85ea47df8ae186204a57d95714";
            width = "<null>";
        }
    );
    product = open;
    type = user;
    uri = "spotify:user:ranjith2010";
}
*/
