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

class QuotesViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var quotesTableView: UITableView!
    fileprivate var viewModel:ReactViewModel!
    fileprivate var quoteCellMaker: DependencyRegistry.QuoteCellMaker!
    weak var navigationCoordinator: NavigationCoordinator?
    private let disposebag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<QuoteSection>(
        configureCell: { (_, tableView, indexPath, item) -> QuoteTableViewCell in
            let viewModel = QuoteCellViewModel(with: item)
            let cell = QuoteTableViewCell.dequeue(from: tableView, for: indexPath, with: viewModel)
            cell.configure(with: viewModel)
            return cell
        },
        titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
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

        QuoteTableViewCell.register(with: quotesTableView)
        updateData(self)
        initTableView()
        self.title = "Quotes"
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func next(with quote: Quote) {
        let args = ["quote": quote]
        navigationCoordinator!.next(arguments: args)
    }
}
