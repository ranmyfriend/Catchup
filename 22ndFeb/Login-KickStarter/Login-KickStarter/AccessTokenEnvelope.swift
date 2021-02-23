//
//  AccessTokenEnvelope.swift
//  Login-KickStarter
//
//  Created by Ranjit on 23/02/21.
//

public struct User: Decodable { //Have to follow kickstarter
    
}

public struct AccessTokenEnvelope {
  public let accessToken: String
  public let user: User

  public init(accessToken: String, user: User) {
    self.accessToken = accessToken
    self.user = user
  }
}

extension AccessTokenEnvelope: Decodable {
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case user
  }
}

