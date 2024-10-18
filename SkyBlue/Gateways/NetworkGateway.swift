//
//  NetworkGateway.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//


protocol FeedsFetchingAPI {
    func fetchFeeds() async throws -> FeedsDTO.FeedsResponse
}


protocol FeedPostsFetchingAPI {
    func fetchFeed(feedURI: String) async throws -> FeedDTO.FeedResponse
}


struct FeedsFetcher: FeedsFetching {

    let feedsFetchingAPI: FeedsFetchingAPI

    func fetchFeeds() async throws -> [Feed] {

        let response = try await feedsFetchingAPI.fetchFeeds()

        let feeds = response.feeds.map { feedDTO in
            Feed(
                uri: feedDTO.uri,
                creator: Feed.Creator(handle: feedDTO.creator.handle,
                                      displayName: feedDTO.creator.displayName),
                displayName: feedDTO.displayName,
                description: feedDTO.description,
                avatar: feedDTO.avatar,
                likeCount: feedDTO.likeCount
            )
        }

        return feeds
    }
}

struct PostsFetcher: PostsFetching {

    let postsFetchingAPI: FeedPostsFetchingAPI

    func fetchPosts(feedURI: String) async throws -> [Post] {

        let response = try await postsFetchingAPI.fetchFeed(feedURI: feedURI)

        let posts = response.feed.map { feedItemDTO in
            let postDTO = feedItemDTO.post
            return Post(
                uri: postDTO.uri,
                author: Post.Author(handle: postDTO.author.handle,
                                    displayName: postDTO.author.displayName,
                                    avatar: postDTO.author.avatar),
                record: postDTO.record.text,
                replyCount: postDTO.replyCount,
                repostCount: postDTO.repostCount,
                likeCount: postDTO.likeCount
            )
        }

        return posts
    }
}
