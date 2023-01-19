//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Thomas Prezioso Jr on 1/7/23.
//

import WidgetKit
import SwiftUI

struct SingleRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }

    func getSnapshot(in context: Context, completion: @escaping (SingleRepoEntry) -> Void) {
        let entry = SingleRepoEntry(date: .now, repo: MockData.repoOne)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SingleRepoEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds

            do {
                // Get Repo
                let repoToShow = RepoURL.swiftNews
                var repo = try await NetworkManager.shared.getRepo(atUrl: repoToShow)
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()

                if context.family == .systemLarge {
                    // Get Contributors
                    let contributors = try await NetworkManager.shared.getContributors(atUrl: repoToShow + "/contributors")
                    // Filter to just the top 4
                    var topFour = Array(contributors.prefix(4))
                    // Download top four avatars
                    for i in topFour.indices {
                        let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                        topFour[i].avatarData = avatarData ?? Data()
                    }
                    repo.contributors = topFour
                }

                // Create Entry & Timeline
                let entry = SingleRepoEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error - \(error.localizedDescription)")
            }
        }
    }
}

struct SingleRepoEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}

struct SingleRepoEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack {
                RepoMediumView(repo: entry.repo)
                ContributorMediumView(repo: entry.repo)
            }
        case .systemSmall, .systemExtraLarge, .accessoryCircular, .accessoryRectangular, .accessoryInline:
            EmptyView()
            
        @unknown default:
            EmptyView()
        }
        
    }
}

struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SingleRepoProvider()) { entry in
            SingleRepoEntryView(entry: entry)
        }
        .configurationDisplayName("Single Repo")
        .description("Keep track of a single repository.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct SingleRepoWidget_Previews: PreviewProvider {
    static var previews: some View {
        SingleRepoEntryView(entry: SingleRepoEntry(date: Date(), repo: MockData.repoOne))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
