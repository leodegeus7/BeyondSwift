//
//  DependencyRegistry.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 08/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Swinject

protocol DependencyRegistry {
    var container: Container { get }
    var navigationCoordinator: NavigationCoordinator! { get }
    
    typealias RootNavigationCoordinatorMaker = (UIViewController) -> NavigationCoordinator
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator
    
    typealias QuoteCellMaker = (UITableView, IndexPath, Quote) -> QuoteTableViewCell
    func makeQuoteCell(for tableView: UITableView, at indexPath: IndexPath, with quote: Quote) -> QuoteTableViewCell
    
    typealias DetailViewControllerMaker = (Quote) -> DetailViewController
    func makeDetailViewController(with quote:Quote) -> DetailViewController
    
}

class DependencyRegistryImpl:DependencyRegistry {
    var container: Container
    var navigationCoordinator: NavigationCoordinator!
    
    init(container: Container) {
        Container.loggingFunction = nil
        self.container = container
        registerDependencies()
        registerViewModels()
        registerViewControllers()
    }
    
    func registerDependencies() {
        container.register(NavigationCoordinator.self) { (_, rootViewController: UIViewController) in
            
            return RootNavigationCoordinatorImpl(with: rootViewController, registry: self)
            }.inObjectScope(.container)
        
        container.register(APIQuotes.self) { _ in APIQuotesImpl() }.inObjectScope(.container)
    }

    func registerViewModels() {
        container.register(ReactViewModel.self) { r in ReactViewModelImpl(apiLayer: r.resolve(APIQuotes.self)!)}
        container.register(DetailViewModel.self) { (_, quote:Quote) in DetailViewModel(with: quote) }
        container.register(QuoteCellViewModel.self) { (_, quote:Quote) in QuoteCellViewModel(with: quote) }
    }
    
    func registerViewControllers() {
        container.register(DetailViewController.self) { (r, quote:Quote) in
            let viewModel = r.resolve(DetailViewModel.self, argument: quote)!
            return DetailViewController(with: viewModel)
        }
    }
    
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinator {
        navigationCoordinator = container.resolve(NavigationCoordinator.self, argument: rootViewController)!
        return navigationCoordinator
    }
    
    func makeQuoteCell(for tableView: UITableView, at indexPath: IndexPath, with quote: Quote) -> QuoteTableViewCell {
        let viewModel = container.resolve(QuoteCellViewModel.self, argument: quote)!
        let cell = QuoteTableViewCell.dequeue(from: tableView, for: indexPath, with: viewModel)
        return cell
    }

    func makeDetailViewController(with quote:Quote) -> DetailViewController {
        return container.resolve(DetailViewController.self, argument: quote)!
    }
}
