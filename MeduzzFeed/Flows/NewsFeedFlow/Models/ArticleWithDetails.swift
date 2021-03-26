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
    let og: Content
    let dateTime: Int
}

struct Content: Decodable {
    let description: String
    let image: String
    let url: String
}

extension ArticleWithDetails {
    private enum CodingKeys: String, CodingKey {
        case root
    }
}

extension Root {
    private enum CodingKeys: String, CodingKey {
        case title
        case secondTitle = "second_title"
        case og
        case dateTime = "datetime"
    }
}

extension Content {
    private enum CodingKeys: String, CodingKey {
        case description
        case image
        case url
    }
}

extension ArticleWithDetails {
    func toDetails() -> Details {
        let root = self.root
        let details = Details(title: root.title, subtitle: root.secondTitle, description: root.og.description, date: root.dateTime, imageUrl: root.og.image, meduzaUrl: root.og.url)
        return details
    }
}
