//
//  ModulesFactory.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

final class ModulesFactory: NewsFeedModuleFactory {
    
    func makeNewsFeed() -> NewsFeedTableView {
        return NewsFeedTableViewController.controllerFromStoryboard(.newsFeed)
    }
    
    func makeArticleDetails() -> ArticleDetailsView {
        return ArticleDetailsViewController.controllerFromStoryboard(.newsFeed)
    }
}
