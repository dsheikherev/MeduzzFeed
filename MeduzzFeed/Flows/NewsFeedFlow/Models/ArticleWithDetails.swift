//
//  ArticleWithDetails.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 06.03.2021.
//

import Foundation

struct ArticleWithDetails: Decodable {
    let root: Root
}

struct Root: Decodable {
    let title: String
    let secondTitle: String?
    let og: Content?
    let datetime: Int
}

struct Content: Decodable {
    let description: String?
    let image: String?
    let url: String
}
