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

class ReactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var quotesTableView: UITableView!
    var viewModel:ReactViewModel!
    private let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let apiQuotes = APIQuotes()
        viewModel = ReactViewModel(api: apiQuotes)
        viewModel.quotes.asObservable().bind { (_) in
             self.quotesTableView.reloadData()
        }.disposed(by: disposebag)
        quotesTableView.delegate = self
        quotesTableView.dataSource = self
        //quotesTableView.rowHeight = UITableView.automaticDimension
        //quotesTableView.estimatedRowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "QuoteCell", bundle: nil)
        quotesTableView.register(nib, forCellReuseIdentifier: "QuoteCellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quotes.value.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCellIdentifier" , for: indexPath) as? QuoteTableViewCell
        if let cell = cell {
            let cellViewModel = QuoteCellViewModel(quote: viewModel.quotes.value[indexPath.row])
            cell.viewModel = cellViewModel
            cell.fillInfo()
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
