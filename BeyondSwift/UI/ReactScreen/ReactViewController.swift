//
//  ReactViewController.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ReactViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var quotesTableView: UITableView!
    fileprivate var viewModel:ReactViewModel!
    fileprivate var quoteCellMaker: DependencyRegistry.QuoteCellMaker!
    weak var navigationCoordinator: NavigationCoordinator?
    private let disposebag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<QuoteSection>(
        configureCell: { (_, tableView, indexPath, item) -> QuoteTableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteTableViewCell
            let viewModel = QuoteCellViewModel(with: item)
            cell?.configure(with: viewModel)
            return cell!
    },
        titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].header
    })
    
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
        
        viewModel.loadData {
            self.quotesTableView.reloadData()
        }
        
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ReactViewController {
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

extension ReactViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func next(with quote: Quote) {
        let args = ["quote": quote]
        navigationCoordinator!.next(arguments: args)
    }
}
