//
//  Codable.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import Foundation

// MARK: - YoutubeData
struct YoutubeData: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item?]
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
    let kind, videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt, channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
