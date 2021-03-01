//
//  ApplicationCoordinator.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 28.02.2021.
//

import Foundation


fileprivate enum FlowSequence {
    case newsFeed
    
    static func nextFlow() -> FlowSequence {
        return .newsFeed
    }
}

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    private var sequence: FlowSequence {
        FlowSequence.nextFlow()
    }
    
    init(coordinatorFactory: CoordinatorFactory, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        switch sequence {
            case .newsFeed:
                runNewsFeedFlow()
        }
    }
    
    private func runNewsFeedFlow() {
        let coordinator = coordinatorFactory.makeNewsFeedCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
