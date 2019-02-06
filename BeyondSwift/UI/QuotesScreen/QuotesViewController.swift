//
//  QuotesViewController.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import CRRefresh

class QuotesViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var quotesTableView: UITableView!
    fileprivate var viewModel:ReactViewModel!
    fileprivate var quoteCellMaker: DependencyRegistry.QuoteCellMaker!
    weak var navigationCoordinator: NavigationCoordinator?
    private let disposebag = DisposeBag()
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    let dataSource = RxTableViewSectionedReloadDataSource<QuoteSection>(
        configureCell: { (_, tableView, indexPath, item) -> Quote2TableViewCell in
            let viewModel = Quote2CellViewModel(with: item)
            let cell = Quote2TableViewCell.dequeue(from: tableView, for: indexPath, with: viewModel)
            cell.configure(with: viewModel)
            return cell
        }
    )
    
    func configure(with viewModel: ReactViewModel,
                   navigationCoordinator: NavigationCoordinator,
                   quoteCellMaker: @escaping DependencyRegistry.QuoteCellMaker) {
        self.viewModel = viewModel
        self.navigationCoordinator = navigationCoordinator
        self.quoteCellMaker = quoteCellMaker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Quote2TableViewCell.register(with: quotesTableView)
        updateData(self)
        initTableView()
        self.title = "Breaking Bad Quotes"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func updateData(_ sender: Any) {
        viewModel.loadData {
            self.quotesTableView.reloadData()
        }
    }
    
}

extension QuotesViewController {
    func initTableView() {
        
        quotesTableView.estimatedRowHeight = 200
        quotesTableView.rowHeight = UITableView.automaticDimension
        quotesTableView.backgroundColor = UIColor(red: 0/255, green: 18/255, blue: 29/255, alpha: 1)
        quotesTableView.separatorColor = UIColor.clear
        refreshButton.tintColor = UIColor.white
        self.quotesTableView.cr.addHeadRefresh(animator: FastAnimator()) {
            DispatchQueue.main.async(execute: {
                self.quotesTableView.cr.beginHeaderRefresh()
                self.viewModel.loadData {
                    self.quotesTableView.reloadData()
                    self.quotesTableView.cr.endHeaderRefresh()
                }
            })
        }
        
        viewModel.sections.asObservable()
            .bind(to: quotesTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposebag)
        
        quotesTableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath])
        }.subscribe { (arg0) in
            let (_,quote) = arg0.element!
            self.next(with: quote)
        }.disposed(by: disposebag)
        
        quotesTableView.rx.setDelegate(self)
            .disposed(by: disposebag)
    }
}

extension QuotesViewController {
    
    func next(with quote: Quote) {
        let args = ["quote": quote]
        navigationCoordinator!.next(arguments: args)
    }
}
