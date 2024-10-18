//
//  PostsListView.swift
//  SkyBlue
//
//  Created by Russell Toon on 16/10/2024.
//

import SwiftUI

struct PostsListView: View {

    var model: PostsListViewModel

    var body: some View {

        Group {
            if let posts = model.posts {
                postsList(posts: posts)
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle(model.title)

    }


    func postsList(posts: [Post]) -> some View {
        List {
            ForEach(posts) { post in

                VStack {
                    HStack {
                        if let displayName = post.author.displayName {
                            Text(displayName)
                                .lineLimit(1)
                                .font(.callout)
                                .bold()
                                .layoutPriority(2)
                        }
                        Text("@\(post.author.handle)")
                            .lineLimit(1)
                            .font(.callout)
                            .truncationMode(.tail)
                            .layoutPriority(1)
                        Spacer()
                    }
                    HStack {
                        Text(post.record)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
        }
    }
}


#Preview {
    // TODO: Populate model
    PostsListView(model: PostsListViewModel(title: "Posts"))
}
