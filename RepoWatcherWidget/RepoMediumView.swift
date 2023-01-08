//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Thomas Prezioso Jr on 1/7/23.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository
    let formatter = ISO8601DateFormatter()
    var daysSinceLastActivity: Int {
        calculateDaysSinceLastActivity(from: repo.pushedAt)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(named: "avatar")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                }.padding(.bottom, 6)
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }

                }
            }
            
            Spacer()
            
            VStack {
                Text("\(daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundColor(daysSinceLastActivity > 50 ? .pink : .green)
                Text("days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }.padding()
    }
    
    func calculateDaysSinceLastActivity (from dateString: String) -> Int {
        
        let lastActivityDate = formatter.date(from: dateString) ?? .now
        return Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
    }
}

struct RepoMediumView_Previews: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: Repository.placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String
    var body: some View {
        Label {
            Text ("\(value)")
                .font(.footnote)
        } icon: {
            Image (systemName: systemImageName)
                .foregroundColor (.green)
        }.fontWeight(.medium)
    }
}
