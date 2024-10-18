//
//  GetFeedsAPI.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//

import Foundation
import OSLog



struct GetFeedAPI: FeedPostsFetchingAPI {

    var bskyAPI: API = BskyAPI()

    func fetchFeed(feedURI: String) async throws -> FeedDTO.FeedResponse {
        let feedQuery = URLQueryItem(name: "feed", value: feedURI)

        return try await bskyAPI.perform(
            path: "/xrpc/app.bsky.feed.getFeed",
            query: [feedQuery]
        )
    }

}

