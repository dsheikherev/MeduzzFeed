//
//  NewsFeedModuleFactory.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

protocol NewsFeedModuleFactory {
    
    func makeNewsFeed() -> NewsFeedTableView
    func makeDetailsOfArticle(with url: String) -> ArticleDetailsView
}
