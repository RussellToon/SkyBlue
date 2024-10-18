//
//  ContentView.swift
//  SkyBlue
//
//  Created by Russell Toon on 14/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    private var feedsFetcher: FeedsFetching
    private var feedsListViewModel: FeedsListViewModel
    private var showSuggestedFeedsUseCase: ShowSuggestedFeeds

    init(
        feedsFetcher: FeedsFetching = FeedsFetcher(feedsFetchingAPI: SuggestedFeedsAPI()),
        //showSuggestedFeedsUseCase: ShowSuggestedFeeds,
        feedsListViewModel: FeedsListViewModel = FeedsListViewModel()
    ) {
        self.feedsListViewModel = feedsListViewModel
        self.feedsFetcher = feedsFetcher
        self.showSuggestedFeedsUseCase = ShowSuggestedFeeds(feedsFetcher: feedsFetcher, feedsDisplayer: feedsListViewModel)
    }


    var body: some View {
        NavigationSplitView {
            FeedsListView(model: feedsListViewModel)
                .onAppear {
                    showSuggestedFeedsUseCase.showSuggestedFeeds()
                }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif

// TODO:
//                ToolbarItem {
//                    Button(action: search) {
//                        Label("Search", systemImage: "magnifier")
//                    }
//                }
            }
        } detail: {
            Text("Select an item")
        }
    }

}

#Preview {
    ContentView()
        //.modelContainer(for: Item.self, inMemory: true)
}
