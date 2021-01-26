//
//  User.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import Foundation

struct User: Codable {
    let userId: Int
    let username: String
    let imageUrl: String
   
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case username = "login"
        case imageUrl = "avatar_url"
    }
}
