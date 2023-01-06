//
//  Repository.swift
//  RepoWatcher
//
//  Created by Thomas Prezioso Jr on 1/5/23.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
    static let placeholder = Repository (
        name: "Your Repo",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 65,
        watchers: 123,
        openIssues: 55,
        pushedAt: "2022-08-09T18:19:30Z"
    )
}
struct Owner: Decodable {
    let avatarUrl: String
}
