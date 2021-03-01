//
//  CoordinatorFactory.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 28.02.2021.
//

import Foundation

protocol CoordinatorFactory {
    
    func makeNewsFeedCoordinator(router: Router) -> Coordinator
}
