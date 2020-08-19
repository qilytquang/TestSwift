//
//  Networking.swift
//  Baitap3+4
//
//  Created by ADMIN on 8/12/2563 BE.
//  Copyright © 2563 BE asiantech. All rights reserved.
//

import Foundation

typealias APICompletion<T> = (APIResult<T>) -> Void

class Networking {
    
    var urlString =  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=lactroi&type=video&key=AIzaSyDMzYJLHg_ynvI_EJHdqpU9qBsoOi3f95A"
    private static var shareAPI: Networking = {
        let networking = Networking()
        return networking
    }()
    
    class func shared() -> Networking {
        return shareAPI
    }
    private init() {}
    
    func request(completion: @escaping(APICompletion<DataAPI>)) {
        var videos: [VideoAPI] = []
        guard let url = URL(string: urlString) else {
            let error = APIResult<DataAPI>.error("URL Error ")
            completion(error)
            return
        }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) {(data, response, error ) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(APIResult<DataAPI>.error("Error "))
                } else {
                    if let data = data {
                        let json = data.toJSON()
                        guard let items = json["items"] as? [JSON] else {return }
                        for item in items {
                            guard let snippet = item["snippet"] as? JSON, let title = snippet["title"] as? String, let publishedAt = snippet["publishedAt"] as? String, let channelTitle = snippet["channelTitle"] as? String, let thumbnail = snippet["thumbnails"] as? JSON, let defaultAPI = thumbnail["default"] as? JSON, let urlAPI = defaultAPI["url"] as? String else { return }
                            let video = VideoAPI(json: item)
                            video.titleVideo = title
                            video.channelTitle = channelTitle
                            video.url = urlAPI
                            video.publishedAt = publishedAt
                            videos.append(video)
                        }
                        completion(.success(DataAPI(videos: videos)))
                    }
                }
            }
        }
        task.resume()
    }
//    func request(with urlString: String, completion: @escaping (Data?, APIError?) -> Void ) {
//        guard let url = URL(string: urlString) else {
//            let error = APIError.error("URL Failed ")
//            completion(nil, error)
//            return
//        }
//        let config = URLSessionConfiguration.ephemeral
//        config.waitsForConnectivity = true
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: url) { (data, response, error ) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    completion(nil, APIError.error(error.localizedDescription))
//                } else {
//                    if let data = data {
//                        completion(data, nil)
//                    } else {
//                        completion(nil, APIError.error("Data format is error "))
//                    }
//                }
//            }
//        }
//        task.resume()
//    }
}
