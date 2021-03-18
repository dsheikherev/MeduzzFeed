//
//  NewsFeed.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 06.03.2021.
//

import Foundation

struct NewsFeed: Decodable {
    let documents: [String : ShortArticle]
}

struct ShortArticle: Decodable {
    let url: String
    let title: String
    let second_title: String?
    let image: Image?
    let layout: String
    let datetime: Int
}

struct Image: Decodable {
    let isMobile: String?
}
