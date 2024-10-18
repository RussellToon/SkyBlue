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
    @Query private var items: [Item]

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
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    // TODO: Remove:
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
