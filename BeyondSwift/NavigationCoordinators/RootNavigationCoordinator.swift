//
//  RootNavigationCoordinator.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 08/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

protocol NavigationCoordinator: class {
    func next(arguments: [String: Any]?)
    func movingBack()
}

enum NavigationState {
    case atMainList,
    atDetailsList
}

class RootNavigationCoordinatorImpl:NavigationCoordinator {
    
    var registry: DependencyRegistry
    var rootViewController: UIViewController
    var navState: NavigationState = .atMainList
    
    init(with rootViewController: UIViewController, registry: DependencyRegistry) {
        self.rootViewController = rootViewController
        self.registry = registry
    }
    
    func next(arguments: [String: Any]?) {
        switch navState {
        case .atMainList:
            showDetails(arguments: arguments)
        case .atDetailsList:
            break
        }
    }
    
    func movingBack() {
        switch navState {
        case .atMainList: //not possible to move back - do nothing
            break
        case .atDetailsList:
            navState = .atMainList
        }
    }
    
    func showDetails(arguments: [String: Any]?) {
        guard let quote = arguments?["quote"] as? Quote else { notifyNilArguments(); return }
        let detailViewController = registry.makeDetailViewController(with: quote)
        rootViewController.navigationController?.pushViewController(detailViewController, animated: true)
        navState = .atDetailsList
    }
    
    func notifyNilArguments() {
        print("notify user of error")
    }

}
