//
//  FeedsDTO.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//


struct FeedsDTO {

    struct FeedsResponse: Codable {

        var feeds: [Feed]

    }

    struct Feed: Codable {

        var uri: String
        var creator: Creator

        struct Creator: Codable {
            var handle: String
            var displayName: String
        }

        var displayName: String
        var description: String?
        var avatar: String?
        var likeCount: Int?

    }

}
