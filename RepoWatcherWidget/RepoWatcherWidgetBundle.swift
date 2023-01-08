//
//  RepoWatcherWidgetBundle.swift
//  RepoWatcherWidget
//
//  Created by Thomas Prezioso Jr on 1/4/23.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        CompactRepoWidget()
        ContributorWidget()
    }
}
