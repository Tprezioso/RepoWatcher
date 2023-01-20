//
//  UserDefaults+Ext.swift
//  RepoWatcher
//
//  Created by Thomas Prezioso Jr on 1/18/23.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.com.Swifttom.RepoWatcher")!
    }
    
    static let repoKey = "repos"
}

enum UserDefaultsError: Error {
    case retrieval
}
