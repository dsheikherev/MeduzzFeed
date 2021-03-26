//
//  NewsFeedFlowCoordinator.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation
import UIKit

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
        newsFeed.onArticleSelected = { [weak self] url in
            self?.showDetailsOfArticle(with: url)
        }
        router.setRootModule(newsFeed)
    }
    
    private func showDetailsOfArticle(with url: String) {
        let articleDetails = moduleFactory.makeDetailsOfArticle(with: url)
        articleDetails.onGoToOriginalLink = { [weak self] urlString in
            guard let url = URL(string: urlString) else { return }
            self?.open(url: url)
        }
        router.push(articleDetails)
    }
    
    private func open(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
