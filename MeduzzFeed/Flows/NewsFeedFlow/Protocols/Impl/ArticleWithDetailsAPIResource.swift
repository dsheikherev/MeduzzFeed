//
//  ArticleWithDetailsAPIResource.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 26.03.2021.
//

import Foundation

struct ArticleWithDetailsAPIResource: APIResource {
    typealias ResourceType = ArticleWithDetails
       
    var methodPath: String {
        return "/api/w5"
    }
    
    var detailsUrl: String
    
    var url: URL {
        let url = URL(string: "https://meduza.io")!
            .appendingPathComponent(methodPath)
            .appendingPathComponent(detailsUrl)
        return url
    }
}
