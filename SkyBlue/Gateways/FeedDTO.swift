//
//  FeedDTO.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//

import Foundation


struct FeedDTO {

    struct FeedResponse: Codable {

        var feed: [FeedItem]

    }

    struct FeedItem: Codable {

        var post: Post

    }

    struct Post: Codable {

        var uri: String
        var author: Author

        struct Author: Codable, Equatable {
            //var did: String
            var handle: String
            var displayName: String?
            var avatar: String?
        }

        var record: Record

        struct Record: Codable {
            var text: String
            var createdAt: Date
        }

        // TODO:
        //var embed: Embed

        //var indexedAt: Date

        var replyCount: Int?
        var repostCount: Int?
        var likeCount: Int?

    }


}
