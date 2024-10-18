//
//  MockEntities.swift
//  SkyBlue
//
//  Created by Russell Toon on 18/10/2024.
//


import XCTest
@testable import SkyBlue


struct MockEntities {

    private static let aFeedDTO = MockDTOs.feedsDTO.feeds[0]

    static let feeds: [Feed] = [
        Feed(
            uri: aFeedDTO.uri,
            creator: Feed.Creator(
                handle: aFeedDTO.creator.handle,
                displayName: aFeedDTO.creator.displayName
            ),
            displayName: aFeedDTO.displayName,
            description: aFeedDTO.description,
            likeCount: aFeedDTO.likeCount
        )
    ]

    private static let feedPostDTO = MockDTOs.feedDTO.feed[0].post

    static let feed: [Post] = [
        Post(
            uri: feedPostDTO.uri,
            author: Post.Author(
                handle: feedPostDTO.author.handle,
                displayName: feedPostDTO.author.displayName,
                avatar: feedPostDTO.author.avatar
            ),
            record: feedPostDTO.record.text,
            replyCount: feedPostDTO.replyCount,
            repostCount: feedPostDTO.repostCount,
            likeCount: feedPostDTO.likeCount
        )
    ]
}
