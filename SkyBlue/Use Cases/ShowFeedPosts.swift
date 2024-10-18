//
//  ShowFeedPosts.swift
//  SkyBlue
//
//  Created by Russell Toon on 16/10/2024.
//


import Foundation


protocol PostsFetching {
    func fetchPosts(feedURI: String) async throws -> [Post]
}


struct ShowFeedPosts {

    var postsFetcher: PostsFetching
    var postsDisplayer: PostsDisplaying

    func showFeedPosts(feedURI: String) {

        Task {
            let posts = try await postsFetcher.fetchPosts(feedURI: feedURI)
            postsDisplayer.show(posts: posts)
            // TODO: Catch and show any errors
        }
    }
}
