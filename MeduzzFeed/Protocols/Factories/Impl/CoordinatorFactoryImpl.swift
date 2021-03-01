//
//  CoordinatorFactoryImpl.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import Foundation

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    func makeNewsFeedCoordinator(router: Router) -> Coordinator {
        return NewsFeedFlowCoordinator(router: router, moduleFactory: ModulesFactory())
    }
    
}
