//
//  LoadImageRequest.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 26.03.2021.
//

import Foundation
import UIKit

class LoadImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension LoadImageRequest: APIRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url, withCompletion: completion)
    }
}
