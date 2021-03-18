//
//  ModulesFactory.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

final class ModulesFactory: NewsFeedModuleFactory {
    
    func makeNewsFeed() -> NewsFeedTableView {
        let vc = NewsFeedTableViewController.controllerFromStoryboard(.newsFeed)
        vc.viewModel = DefaultNewsFeedTableViewModel()
        return vc
    }
    
    func makeArticleDetails() -> ArticleDetailsView {
        return ArticleDetailsViewController.controllerFromStoryboard(.newsFeed)
    }
}
