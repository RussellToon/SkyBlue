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

        let doNotShowFeedsNamed = [
            "Media",
            "The 'Gram",
            "Popular With Friends",
            "Mutuals",
            "Mentions",
            "Followers",
            "My Bangers",
            "OnlyPosts"
        ]

        Task {
            let feeds = try await feedsFetcher.fetchFeeds()
            let populatedFeeds = feeds.filter { feed in
                !doNotShowFeedsNamed.contains(feed.displayName)
            }
            feedsDisplayer.show(feeds: populatedFeeds)
        }
    }
}
