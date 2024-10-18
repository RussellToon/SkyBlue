//
//  TestMocks.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//

import XCTest
@testable import SkyBlue


// TODO: Rename these to Spys

class MockAPI: API {

    var performReturnWith: Decodable
    var performCalledWithArgs: (path: String, query: [URLQueryItem])?

    init(performReturnWith: Decodable) {
        self.performReturnWith = performReturnWith
    }

    func perform<T: Decodable>(path: String, query: [URLQueryItem]) async throws -> T {
        performCalledWithArgs = (path, query)
        let result: T = performReturnWith as! T
        return result
    }
}


@Observable
class MockPostsDisplayer: PostsDisplaying {

    var shownPosts: [Post]?

    func show(posts: [Post]) {
        shownPosts = posts
    }
}


@Observable
class MockPostsFetcher: PostsFetching {

    var fetchPostsFeedURI: String?
    var mockPostsToReturn: [Post] = []

    func fetchPosts(feedURI: String) async throws -> [Post] {
        fetchPostsFeedURI = feedURI
        return mockPostsToReturn
    }
}


@Observable
class MockFeedsDisplayer: FeedsDisplaying {

    var shownFeeds: [Feed]?

    func show(feeds: [Feed]) {
        shownFeeds = feeds
    }
}


class MockFeedsFetcher: FeedsFetching {

    var fetchFeedsCalled = false
    var mockFeedsToReturn: [Feed] = []

    func fetchFeeds() async throws -> [Feed] {
        fetchFeedsCalled = true
        return mockFeedsToReturn
    }
}


class MockFeedPostsFetchingAPI: FeedPostsFetchingAPI {

    var mockPostsToReturn = FeedDTO.FeedResponse(feed: [])

    func fetchFeed(feedURI: String) async throws -> FeedDTO.FeedResponse {
        return mockPostsToReturn
    }
}


class MockFeedsFetchingAPI: FeedsFetchingAPI {

    var mockFeedToReturn = FeedsDTO.FeedsResponse(feeds: [])

    func fetchFeeds() async throws -> FeedsDTO.FeedsResponse {
        return mockFeedToReturn
    }
}


class MockTransport {

    static func returningFeeds(request: URLRequest) async throws -> (Data, URLResponse) {
        (MockData.suggestedFeeds.data(using: .utf8)!, URLResponse())
    }

    static func returningFeed(request: URLRequest) async throws -> (Data, URLResponse) {
        (MockData.scienceFeed.data(using: .utf8)!, URLResponse())
    }

}
