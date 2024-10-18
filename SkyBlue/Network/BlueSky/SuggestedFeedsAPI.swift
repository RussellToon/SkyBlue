//
//  SuggestedFeeds.swift
//  SkyBlue
//
//  Created by Russell Toon on 14/10/2024.
//


import Foundation
import OSLog


struct SuggestedFeedsAPI: FeedsFetchingAPI {

    var bskyAPI: API = BskyAPI()

    func fetchFeeds() async throws -> FeedsDTO.FeedsResponse {
        let path = "/xrpc/app.bsky.feed.getSuggestedFeeds"

        return try await bskyAPI.perform(path: path)
    }

}

