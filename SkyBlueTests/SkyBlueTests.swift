//
//  SkyBlueTests.swift
//  SkyBlueTests
//
//  Created by Russell Toon on 14/10/2024.
//

import XCTest
@testable import SkyBlue


final class SkyBlueTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private let feedQueryURL = "https://public.api.bsky.app/xrpc/app.bsky.feed.getFeed?feed=at://did:plc:jfhpnnst6flqway4eaeqzj2a/app.bsky.feed.generator/for-science"


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }


    func testSuggestedFeedsAPIFetchCallsAPIPerform() async throws {
        var suggestedFeedsAPI = SuggestedFeedsAPI()
        let mockFeedsResponse = FeedsDTO.FeedsResponse(feeds: [])
        let mockAPI = MockAPI(performReturnWith: mockFeedsResponse)
        suggestedFeedsAPI.bskyAPI = mockAPI

        let feeds = try await suggestedFeedsAPI.fetchFeeds()

        let expectedArgs = (path: "/xrpc/app.bsky.feed.getSuggestedFeeds", query: [URLQueryItem]())
        guard let (path, query) = mockAPI.performCalledWithArgs else {
            XCTFail("Perform not called"); return
        }
        XCTAssertEqual(path, expectedArgs.path, "Perform called with wrong args")
        XCTAssertEqual(query, expectedArgs.query, "Perform called with wrong args")
        XCTAssert(feeds.feeds.isEmpty) // TODO: Populate with mock data
    }

    func testGetFeedAPIFetchCallsAPIPerform() async throws {
        var getFeedAPI = GetFeedAPI()
        let mockFeedResponse = FeedDTO.FeedResponse(feed: [])
        let mockAPI = MockAPI(performReturnWith: mockFeedResponse)
        getFeedAPI.bskyAPI = mockAPI

        let feed = try await getFeedAPI.fetchFeed(feedURI: feedQueryURL)

        let feedQuery = URLQueryItem(name: "feed", value: feedQueryURL)
        let expectedArgs = (path: "/xrpc/app.bsky.feed.getFeed", query: [feedQuery])
        guard let (path, query) = mockAPI.performCalledWithArgs else {
            XCTFail("Perform not called"); return
        }
        XCTAssertEqual(path, expectedArgs.path, "Perform called with wrong args")
        XCTAssertEqual(query, expectedArgs.query, "Perform called with wrong args")
        XCTAssert(feed.feed.isEmpty) // TODO: Populate with mock data
    }

    func testShowFeedPostsCallsDisplayerShow() throws {
        let mockPostsFetcher = MockPostsFetcher()
        let mockPostsDisplayer = MockPostsDisplayer()
        let requestURI = "https://test/feedURI"

        let sut = ShowFeedPosts(postsFetcher: mockPostsFetcher, postsDisplayer: mockPostsDisplayer)

        let displayChangedExpectation = XCTestExpectation(description: "Display changed.")

        withObservationTracking {
            let _ = mockPostsDisplayer.shownPosts
        } onChange: {
            displayChangedExpectation.fulfill()
        }

        sut.showFeedPosts(feedURI: requestURI)

        wait(for: [displayChangedExpectation], timeout: 1.0)

        XCTAssertEqual(mockPostsFetcher.fetchPostsFeedURI, requestURI)
        XCTAssert(mockPostsDisplayer.shownPosts?.count == 0) // TODO: Populate with mock data
    }

    func testShowSuggestedFeedsCallsDisplayerShow() {
        let mockFeedsFetcher = MockFeedsFetcher()
        let mockFeedsDisplayer = MockFeedsDisplayer()

        let sut = ShowSuggestedFeeds(feedsFetcher: mockFeedsFetcher, feedsDisplayer: mockFeedsDisplayer)

        let displayChangedExpectation = XCTestExpectation(description: "Display changed.")

        withObservationTracking {
            let _ = mockFeedsDisplayer.shownFeeds
        } onChange: {
            displayChangedExpectation.fulfill()
        }

        sut.showSuggestedFeeds()

        wait(for: [displayChangedExpectation], timeout: 1.0)

        XCTAssert(mockFeedsFetcher.fetchFeedsCalled)
        XCTAssert(mockFeedsDisplayer.shownFeeds?.count == 0) // TODO: Populate with mock data
    }

    func testGatewayFetchPostsReturnsEntities() async throws {
        let mockFeedPostsFetchingAPI = MockFeedPostsFetchingAPI()
        mockFeedPostsFetchingAPI.mockPostsToReturn = MockDTOs.feedDTO

        let sut = PostsFetcher(postsFetchingAPI: mockFeedPostsFetchingAPI)

        let result = try await sut.fetchPosts(feedURI: "https://test/posts")

        let expectedResult: [Post] = MockEntities.feed
        XCTAssertEqual(result, expectedResult)
    }

    func testGatewayFetchFeedsReturnsEntities() async throws {
        let mockFeedsFetchingAPI = MockFeedsFetchingAPI()
        mockFeedsFetchingAPI.mockFeedToReturn = MockDTOs.feedsDTO

        let sut = FeedsFetcher(feedsFetchingAPI: mockFeedsFetchingAPI)

        let result = try await sut.fetchFeeds()

        let expectedResult: [Feed] = MockEntities.feeds
        XCTAssertEqual(result, expectedResult)
    }

    func testGetFeedsAPIParsesToDTOs() async throws {
        let mockTestURLString = "https://test/getFeeds"
        let mockTestURL = URL(string: mockTestURLString)!
        let transport: BskyAPI.Transport = {_ in try await MockTransport.returningFeeds(request:URLRequest(url: mockTestURL))}
        let api = BskyAPI(baseURL: mockTestURL, transport: transport)
        let suggestedFeedsAPI = SuggestedFeedsAPI(bskyAPI: api)
        let feeds = try await suggestedFeedsAPI.fetchFeeds()
        print("Feed items: \(feeds.feeds.count)")
        XCTAssertEqual(feeds.feeds.count, 1)
    }

    func testGetFeedAPIParsesToDTOs() async throws {
        let mockTestURLString = "https://test/getFeed"
        let mockTestURL = URL(string: mockTestURLString)!
        let transport: BskyAPI.Transport = {_ in try await MockTransport.returningFeed(request:URLRequest(url: mockTestURL))}
        let api = BskyAPI(baseURL: mockTestURL, transport: transport)
        let getFeedAPI = GetFeedAPI(bskyAPI: api)
        let feed = try await getFeedAPI.fetchFeed(feedURI: mockTestURLString)
        print("Feed items: \(feed)")
        XCTAssertEqual(feed.feed.count, 1)
    }

    func testPostIDEqualsURI() {
        let post = MockEntities.feed[0]
        XCTAssertEqual(post.id, post.uri)
    }

    func testPostsListViewModelSetsPostsOnShow() {
        let postsListViewModel = PostsListViewModel(
            title: "Title", posts: []
        )

        let displayChangedExpectation = XCTestExpectation(description: "Display changed.")

        withObservationTracking {
            let _ = postsListViewModel.posts
        } onChange: {
            displayChangedExpectation.fulfill()
        }

        postsListViewModel.show(posts: MockEntities.feed)

        wait(for: [displayChangedExpectation], timeout: 1.0)

        XCTAssertEqual(postsListViewModel.posts, MockEntities.feed)
    }

    func testFeedsListViewModelSetsFeedsOnShow() {
        let feedsListViewModel = FeedsListViewModel()

        let displayChangedExpectation = XCTestExpectation(description: "Display changed.")

        withObservationTracking {
            let _ = feedsListViewModel.feeds
        } onChange: {
            displayChangedExpectation.fulfill()
        }

        feedsListViewModel.show(feeds: MockEntities.feeds)

        wait(for: [displayChangedExpectation], timeout: 1.0)

        XCTAssertEqual(feedsListViewModel.feeds, MockEntities.feeds)
    }

    func testFeedPostsDependenciesCreate() {

        let feed = MockEntities.feeds[0]

        let postsListDependencies = Dependencies.feedPostsDependencies(feed: feed)

        let (postsListViewModel, showFeedPostsUseCase) = postsListDependencies

        XCTAssertEqual(postsListViewModel.title, "Feed name")
    }


}


