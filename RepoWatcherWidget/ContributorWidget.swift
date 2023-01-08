//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Thomas Prezioso Jr on 1/7/23.
//

import WidgetKit
import SwiftUI

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> Void) {
       let entry = ContributorEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>) -> Void) {
        let nextUpdate = Date() .addingTimeInterval (43200) // 12 hours in seconds
        let entry = ContributorEntry(date: .now)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ContributorEntry: TimelineEntry {
    var date: Date
}

struct ContributorEntryView : View {
    var entry: ContributorEntry
    
    var body: some View {
        RepoMediumView(repo: MockData.repoOne)
    }
}

struct ContributorWidget: Widget {
    let kind: String = "ContributorRepoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            ContributorEntryView(entry: entry)
        }
        .configurationDisplayName("Contributors")
        .description("Keep track of a repository's top contributors.")
        .supportedFamilies([.systemLarge])
    }
}

struct ContributorWidget_Previews: PreviewProvider {
    static var previews: some View {
        ContributorEntryView(entry: ContributorEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
