//
//  SuggestedFeeds.swift
//  SkyBlue
//
//  Created by Russell Toon on 15/10/2024.
//

import SwiftUI


protocol FeedsDisplaying {
    func show(feeds: [Feed])
}


@Observable
class FeedsListViewModel: FeedsDisplaying {

    var feeds: [Feed]?

    func show(feeds: [Feed]) {
        Task { @MainActor in
            self.feeds = feeds
        }
    }

}
