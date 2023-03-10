//
//  Repository.swift
//  RepoWatcher
//
//  Created by Thomas Prezioso Jr on 1/5/23.
//

import Foundation

struct Repository {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    var avatarData: Data
    var contributors: [Contributor] = []
    
    var daysSinceLastActivity: Int {
        let formatter = ISO8601DateFormatter()
        let lastActivityDate = formatter.date(from: pushedAt) ?? .now
        return Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
    }

}
extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: String
        
        var repo: Repository {
            Repository(
                name: name,
                owner: owner,
                hasIssues: hasIssues,
                forks: forks,
                watchers: watchers,
                openIssues: openIssues,
                pushedAt: pushedAt,
                avatarData: Data()
            )
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
