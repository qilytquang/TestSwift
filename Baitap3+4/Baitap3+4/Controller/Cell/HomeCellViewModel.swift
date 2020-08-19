//
//  HomeCellViewModel.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import UIKit

class HomeCellViewModel {
    let titleVideo: String
    let channelTitle: String
    let publishedAt: String
    let imageURL: String
    
    init(_ video: Video) {
        titleVideo = video.title
        channelTitle = video.channel
        publishedAt = video.publishedAt
        imageURL = video.url
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        ImageCache.loadImage(urlString: imageURL, completion: completion)
    }
}
