//
//  ImageCache.swift
//  Baitap3+4
//
//  Created by Quang on 8/19/20.
//  Copyright © 2020 asiantech. All rights reserved.
//

import UIKit

class ImageCache {
    private static var cache: Dictionary<String, UIImage> = [:]
    
    static func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache[urlString] {
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    cache[urlString] = image
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
