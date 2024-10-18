//
//  Dependencies.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//

struct Dependencies {

    static func feedPostsDependencies(feed: Feed) -> (PostsListViewModel, ShowFeedPosts) {

        /*
         init(
         feedsFetcher: FeedsFetching = FeedsFetcher(feedsFetchingAPI: SuggestedFeedsAPI()),
         //showSuggestedFeedsUseCase: ShowSuggestedFeeds,
         feedsListViewModel: FeedsListViewModel = FeedsListViewModel()
         ) {
         self.feedsListViewModel = feedsListViewModel
         self.feedsFetcher = feedsFetcher
         self.showSuggestedFeedsUseCase = ShowSuggestedFeeds(feedsFetcher: feedsFetcher, feedsDisplayer: feedsListViewModel)
         }
         */

        let postsListViewModel = PostsListViewModel(title: feed.displayName)
        let postsFetcher: PostsFetching = PostsFetcher(postsFetchingAPI: GetFeedAPI())
        let showFeedPostsUseCase: ShowFeedPosts = ShowFeedPosts(postsFetcher: postsFetcher, postsDisplayer: postsListViewModel)

        return (postsListViewModel, showFeedPostsUseCase)
    }

}
