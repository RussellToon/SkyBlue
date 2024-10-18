//
//  MockData.swift
//  SkyBlue
//
//  Created by Russell Toon on 18/10/2024.
//


struct MockData {

    static var suggestedFeeds =
"""
{
  "feeds": [
    {
      "uri": "at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot",
      "cid": "bafyreievgu2ty7qbiaaom5zhmkznsnajuzideek3lo7e65dwqlrvrxnmo4",
      "did": "did:web:discover.bsky.app",
      "creator": {
        "did": "did:plc:z72i7hdynmk6r22z27h6tvur",
        "handle": "bsky.app",
        "displayName": "Bluesky",
        "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:z72i7hdynmk6r22z27h6tvur/bafkreihagr2cmvl2jt4mgx3sppwe2it3fwolkrbtjrhcnwjk4jdijhsoze@jpeg",
        "associated": {
          "chat": {
            "allowIncoming": "none"
          }
        },
        "labels": [],
        "createdAt": "2023-04-12T04:53:57.057Z",
        "description": "official Bluesky account (check domain👆)\n\nPress: press@blueskyweb.xyz\nSupport: support@bsky.app",
        "indexedAt": "2024-10-17T07:17:00.612Z"
      },
      "displayName": "Discover",
      "description": "Trending content from your personal network",
      "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:z72i7hdynmk6r22z27h6tvur/bafkreidljdg62x3zhlweyzshoekrw2znokytt5tmib7g4xsngwvpnf6ule@jpeg",
      "likeCount": 20804,
      "labels": [],
      "indexedAt": "2023-05-19T23:19:19.592Z"
    }
  ],
  "cursor": "9951"
}
"""


    static var scienceFeed =
"""
{
  "feed": [
    {
      "post": {
        "uri": "at://did:plc:huxnm7v2o5vv673swzhs2ckl/app.bsky.feed.post/3l6ql24igm62d",
        "cid": "bafyreih6exrwee7qn2ki37pjnvimkfjvxvj6whm6g2c3qi4ifnmrdu55ei",
        "author": {
          "did": "did:plc:huxnm7v2o5vv673swzhs2ckl",
          "handle": "witchdoctor.bsky.social",
          "displayName": "Witch Doctor",
          "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:huxnm7v2o5vv673swzhs2ckl/bafkreicc7rcy3ce3t4ddjnu57fqwbler5f3n2yuepr5wicpx4k2oxjebum@jpeg",
          "labels": [],
          "createdAt": "2023-08-20T17:25:24.556Z"
        },
        "record": {
          "$type": "app.bsky.feed.post",
          "createdAt": "2024-10-17T23:07:29.119Z",
          "text": "Some very straightforward text"
        },
        "replyCount": 0,
        "repostCount": 1,
        "likeCount": 7,
        "quoteCount": 2
      }
    }
  ],
  "cursor": "1729185794045::bafyreif6iy7fo5fpstqe53g6p556666fw26admptxsodylw5f3ajlvj6lm"
}
"""

}
