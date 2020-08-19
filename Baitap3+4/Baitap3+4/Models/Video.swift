//
//  Video.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import Foundation

class Video {
    let title: String
    let channel: String
    let publishedAt: String
    let url: String
    
    init?(_ snippet: JSON) {
        guard
            let title = snippet["title"] as? String,
            let publishedAt = snippet["publishedAt"] as? String,
            let channelTitle = snippet["channelTitle"] as? String,
            let thumbnail = snippet["thumbnails"] as? JSON,
            let defaultAPI = thumbnail["default"] as? JSON,
            let urlAPI = defaultAPI["url"] as? String else {
                return nil
        }
        self.title = title
        self.channel = channelTitle
        self.publishedAt = publishedAt
        self.url = urlAPI
    }
}
