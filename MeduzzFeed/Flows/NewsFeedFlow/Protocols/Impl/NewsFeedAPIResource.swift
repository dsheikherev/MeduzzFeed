//
//  NewsFeedAPIResource.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 07.03.2021.
//

import Foundation

struct NewsFeedAPIResource: APIResource {
    typealias ResourceType = NewsFeed
    
    var pageNumber: Int?
    
    var methodPath: String {
        return "/api/w5/search"
    }
    
    var url: URL {
        var components = URLComponents(string: "https://meduza.io")!
        components.path = methodPath
        components.queryItems = [
            URLQueryItem(name: "chrono", value: "news"),
            URLQueryItem(name: "page", value: "\(pageNumber ?? 0)"),
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "locale", value: "en"),
        ]
        return components.url!
    }
}
