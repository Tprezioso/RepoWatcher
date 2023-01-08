//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Thomas Prezioso Jr on 1/7/23.
//

import Foundation

struct MockData {
    static let repoOne = Repository (
        name: "Repo 1",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 65,
        watchers: 123,
        openIssues: 55,
        pushedAt: "2022-08-09T18:19:30Z",
        avatarData: Data(),
        contributors: [
            Contributor(login: "Sean Allen", avatarUrl: "",contributions: 42, avatarData: Data()),
            Contributor(login: "Michael Jordan", avatarUrl: "", contributions: 23, avatarData: Data()),
            Contributor(login: "Steph Curry", avatarUrl: "", contributions: 10, avatarData: Data()),
            Contributor(login: "Sean Allen", avatarUrl: "", contributions: 42, avatarData: Data())
        ]
    )
    
    static let repoTwo = Repository (
        name: "Repo 2",
        owner: Owner(avatarUrl: ""),
        hasIssues: false,
        forks: 1,
        watchers: 12,
        openIssues: 555,
        pushedAt: "2022-12-31T18:19:30Z",
        avatarData: Data()
    )
}
