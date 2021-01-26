//
//  Repo.swift
//  GitHubRepos
//
//  Created by Giorgi on 1/26/21.
//

import Foundation

struct Repo: Codable {
    let id: Int
    let name: String
    let privacyStatus: Bool
    let repoUrl: String
    
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case privacyStatus = "private"
        case repoUrl = "url"
        case user = "owner"
    }
    
}
