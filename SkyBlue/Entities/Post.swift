//
//  Posts.swift
//  SkyBlue
//
//  Created by Russell Toon on 16/10/2024.
//


import Foundation


struct Post: Codable, Equatable, Identifiable {

    // TODO: Resolve Strings to URLs etc.

    init(uri: String, author: Author, record: String, replyCount: Int? = nil, repostCount: Int? = nil, likeCount: Int? = nil) {
        self.uri = uri
        self.author = author
        self.record = record
        self.replyCount = replyCount
        self.repostCount = repostCount
        self.likeCount = likeCount
    }

    var id: String {
        uri
    }

    var uri: String
    var author: Author

    struct Author: Codable, Equatable {
        //var did: String
        var handle: String
        var displayName: String?
        var avatar: String?
    }

    var record: String
    // TODO:
    //var embed: Embed

    var replyCount: Int?
    var repostCount: Int?
    var likeCount: Int?

}
