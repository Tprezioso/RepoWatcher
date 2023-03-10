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
                Text("\(repo.daysSinceLastActivity)")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundColor(repo.daysSinceLastActivity > 50 ? .pink : .green)
                Text("days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }.padding()
    }
    
}

struct RepoMediumView_Previews: PreviewProvider {
    static var previews: some View {
        RepoMediumView(repo: MockData.repoOne)
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
