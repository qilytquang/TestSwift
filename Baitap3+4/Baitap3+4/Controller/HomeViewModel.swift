//
//  HomeViewModel.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import Foundation
import UIKit

typealias Completion = (Bool, String?) -> Void

class HomeViewModel {
    private var allVideos: [Video]
    private var videos: [Video]
    
    init() {
        allVideos = []
        videos = []
    }
    
    func loadAPI(completion: @escaping Completion) {
        Networking.shared().request { (apiResult: APIResult<DataAPI>) in
            switch apiResult {
            case.error(let stringError):
                completion(false, stringError)
            case.success(let result):
                self.allVideos = result.videos
                self.videos.append(contentsOf: self.allVideos)
                completion(true, nil)
            }
        }
    }
    
    func search(_ searchText: String) {
        videos.removeAll()
        guard !searchText.isEmpty else {
            videos.append(contentsOf: allVideos)
            return
        }
        for video in allVideos {
            if video.title.uppercased().contains(searchText.uppercased()) {
                videos.append(video)
            }
        }
    }
    
    func numberOfRowInSection() -> Int {
        return videos.count
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        let video = videos[indexPath.row]
        return HomeCellViewModel(video)
    }
}
