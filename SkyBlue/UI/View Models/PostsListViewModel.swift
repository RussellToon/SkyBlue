//
//  PostsListViewModel.swift
//  SkyBlue
//
//  Created by Russell Toon on 16/10/2024.
//

import SwiftUI


protocol PostsDisplaying {
    func show(posts: [Post])
}


@Observable
class PostsListViewModel: PostsDisplaying {

    var title: String
    var posts: [Post]?

    init(title: String, posts: [Post]? = nil) {
        self.title = title
        self.posts = posts
    }
    
    func show(posts: [Post]) {
        Task { @MainActor in
            self.posts = posts
        }
    }

}
