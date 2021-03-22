//
//  NewsFeed.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 06.03.2021.
//

import Foundation

struct NewsFeed: Decodable {
    let documents: [String : Document]
}

struct Document: Decodable {
    let url: String
    let title: String
    let secondTitle: String?
    let image: Image?
    let dateTime: Int
}

struct Image: Decodable {
    let isMobile: String?
}

extension NewsFeed {
    private enum CodingKeys: String, CodingKey {
        case documents
    }
}

extension Document {
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case secondTitle = "second_title"
        case image
        case dateTime = "datetime"
    }
}

extension Image {
    private enum CodingKeys: String, CodingKey {
        case isMobile
    }
}

extension NewsFeed {
    func toArticles() -> [Article] {
        var articles: [Article] = []
        for document in self.documents.values {
            let article = Article(url: document.url, title: document.title, subtitle: document.secondTitle, date: document.dateTime)
            articles.append(article)
        }
        return articles
    }
}
