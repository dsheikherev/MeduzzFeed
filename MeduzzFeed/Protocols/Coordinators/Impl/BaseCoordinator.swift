//
//  BaseCoordinator.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 28.02.2021.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var children = Array<Coordinator>()
    
    func start() {
    }
    
    // add only unique object
    func addDependency(_ coordinator: Coordinator) {
        guard !children.contains(where: { $0 === coordinator }) else {
            return
        }
        children.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard !children.isEmpty, let coordinator = coordinator else { return }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator,
           !coordinator.children.isEmpty {
            coordinator.children
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        
        for (index, element) in children.enumerated() where element === coordinator {
            children.remove(at: index)
            break
        }
    }
    
}
