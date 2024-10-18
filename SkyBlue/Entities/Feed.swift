//
//  Feeds.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//


import Foundation


struct Feed: Codable, Equatable, Identifiable {

    // TODO: Resolve Strings to URLs etc.

    init(uri: String, creator: Creator, displayName: String, description: String? = nil, avatar: String? = nil, likeCount: Int? = nil) {
        self.uri = uri
        self.creator = creator
        self.displayName = displayName
        self.description = description
        self.avatar = avatar
        self.likeCount = likeCount
    }

    var id: String {
        uri
    }

    var uri: String
    var creator: Creator

    struct Creator: Codable, Equatable {
        var handle: String
        var displayName: String
    }

    var displayName: String
    var description: String?
    var avatar: String? // TODO: URL
    var likeCount: Int?

}
