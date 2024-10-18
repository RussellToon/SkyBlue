//
//  ShowSuggestedFeeds.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//


import Foundation


protocol FeedsFetching {
    func fetchFeeds() async throws -> [Feed]
}


struct ShowSuggestedFeeds {

    var feedsFetcher: FeedsFetching
    var feedsDisplayer: FeedsDisplaying

    func showSuggestedFeeds() {

        Task {
            let feeds = try await feedsFetcher.fetchFeeds()
            let populatedFeeds = feeds.filter { feed in
                !["Popular With Friends", "Mutuals"].contains(feed.displayName)
            }
            feedsDisplayer.show(feeds: populatedFeeds)
        }
    }
}
