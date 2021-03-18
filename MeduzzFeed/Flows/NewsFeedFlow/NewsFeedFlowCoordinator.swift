//
//  NewsFeedFlowCoordinator.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

final class NewsFeedFlowCoordinator: BaseCoordinator {
    
    private let router: Router
    private let moduleFactory: ModulesFactory
    
    init(router: Router, moduleFactory: ModulesFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        showNewsFeed()
    }
    
    private func showNewsFeed() {
        let newsFeed = moduleFactory.makeNewsFeed()
        newsFeed.onArticleSelected = { [weak self] article in
            self?.showDetailsOf(article)
        }
        router.setRootModule(newsFeed)
    }
    
    private func showDetailsOf(_ article: Article) {
        let articleDetails = moduleFactory.makeArticleDetails()
        articleDetails.article = article
        articleDetails.onGoToOriginalLink = { [weak self] urlString in
            
        }
        router.push(articleDetails)
    }
}
