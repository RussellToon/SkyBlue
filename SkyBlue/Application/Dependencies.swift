//
//  Dependencies.swift
//  SkyBlue
//
//  Created by Russell Toon on 17/10/2024.
//

struct Dependencies {

    static func feedPostsDependencies(feed: Feed) -> (PostsListViewModel, ShowFeedPosts) {

        let postsListViewModel = PostsListViewModel(title: feed.displayName)
        let postsFetcher: PostsFetching = PostsFetcher(postsFetchingAPI: GetFeedAPI())
        let showFeedPostsUseCase: ShowFeedPosts = ShowFeedPosts(postsFetcher: postsFetcher, postsDisplayer: postsListViewModel)

        return (postsListViewModel, showFeedPostsUseCase)
    }

}
