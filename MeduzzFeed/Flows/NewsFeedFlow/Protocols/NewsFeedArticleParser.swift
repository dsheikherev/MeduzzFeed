//
//  NewsFeedArticleParser.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 23.02.2021.
//

import Foundation

protocol NewsFeedArticleParser {
    func parse(_ article: Article)
}
