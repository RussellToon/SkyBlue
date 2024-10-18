//
//  MockDTOs.swift
//  SkyBlue
//
//  Created by Russell Toon on 18/10/2024.
//


import XCTest
@testable import SkyBlue


struct MockDTOs {

    static let feedsDTO = FeedsDTO.FeedsResponse(
        feeds: [
            FeedsDTO.Feed(
                uri: "https://test/feedsDTO",
                creator: FeedsDTO.Feed.Creator(handle: "Creator Handle", displayName: "Creator DisplayName"),
                displayName: "Feed name",
                description: "Description",
                avatar: nil,
                likeCount: 7
            )
        ]
    )

    static let feedDTO = FeedDTO.FeedResponse(feed: [
        FeedDTO.FeedItem(
            post: FeedDTO.Post(
                uri: "https://test/feedDTO",
                author: FeedDTO.Post.Author(
                    handle: "Author handle",
                    displayName: "Author display name",
                    avatar: nil
                ),
                record: FeedDTO.Post.Record(
                    text: "Post text", createdAt: Date.distantFuture
                ),
                replyCount: 0,
                repostCount: 3,
                likeCount: 6
            )
        )
    ])
}
