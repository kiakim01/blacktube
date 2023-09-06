//
//  Video.swift
//  blacktube
//
//  Created by 조규연 on 2023/09/04.
//

import Foundation

struct Video: Equatable, Codable {
    static func == (lhs: Video, rhs: Video) -> Bool {
        return lhs.title == rhs.title && lhs.channelTitle == rhs.channelTitle
    }
    
    let title: String
    let thumbnailURL: URL
    let viewCount: String
    let channelTitle: String
//    let item: [String: Any]
    let tags: [String]
    let publishedDate: String
    let videoId: String
    let description: String
}

var likedVideos: [Video] = []
var videos: [Video] = []
