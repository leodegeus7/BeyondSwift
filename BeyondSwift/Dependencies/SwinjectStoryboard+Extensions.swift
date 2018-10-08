//
//  SwinjectStoryboard+Extensions.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 08/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    public static func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistryImpl(container: defaultContainer)
        }
        
        let dependencyRegistry: DependencyRegistry = AppDelegate.dependencyRegistry
        
        func main() {
            dependencyRegistry.container.storyboardInitCompleted(QuotesViewController.self) { r, viewController in
                
                let coordinator = dependencyRegistry.makeRootNavigationCoordinator(rootViewController: viewController)
    
                setupData(resolver: r, navigationCoordinator: coordinator)
                
                let viewModel = r.resolve(ReactViewModel.self)!
                
                //NOTE: We don't have access to the constructor for this VC so we are using method injection
                viewController.configure(with: viewModel, navigationCoordinator: coordinator, quoteCellMaker: dependencyRegistry.makeQuoteCell)
            }
        }
        
        func setupData(resolver r: Resolver, navigationCoordinator: NavigationCoordinator) {
            AppDelegate.navigationCoordinator = navigationCoordinator
        }
        
        main()
    }
}
