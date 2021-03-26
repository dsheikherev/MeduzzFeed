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
    
    func makeDetailsOfArticle(with url: String) -> ArticleDetailsView {
        let vc = ArticleDetailsViewController.controllerFromStoryboard(.newsFeed)
        let vm = DefaultArticleDetailsViewModel()
        vm.url = url
        vc.viewModel = vm
        return vc
    }
}
