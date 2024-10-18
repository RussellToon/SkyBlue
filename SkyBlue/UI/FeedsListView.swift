//
//  FeedsListView.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//

import SwiftUI

struct FeedsListView: View {

    var model: FeedsListViewModel

    var body: some View {

        Group {
            if let feeds = model.feeds {
                feedsList(feeds: feeds)
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle("BlueSky Feeds")

    }


    func feedsList(feeds: [Feed]) -> some View {
        List {
            ForEach(feeds) { feed in
                NavigationLink {
                    let (postsListViewModel, showFeedPostsUseCase) = Dependencies.feedPostsDependencies(feed: feed)
                    PostsListView(model: postsListViewModel)
                        .onAppear {
                            showFeedPostsUseCase.showFeedPosts(feedURI: feed.uri)
                        }

                } label: {

                    VStack {
                        HStack {
                            //Spacer()
                            Text("\(feed.displayName)")
                                .lineLimit(1)
                                .font(.callout)
                                .bold()
                            Spacer()
                        }
                        if let description = feed.description {
                            HStack {
                                Text(description)
                                    .font(.footnote)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    // TODO: Populate model
    FeedsListView(model: FeedsListViewModel())
}
