//
//  NewsFeedAPIResource.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 07.03.2021.
//

import Foundation

struct NewsFeedAPIResource: APIResource {
    typealias ResourceType = NewsFeed
    
    var id: String?
    
    var methodPath: String {
        return "/api/w5/search"
    }
}
