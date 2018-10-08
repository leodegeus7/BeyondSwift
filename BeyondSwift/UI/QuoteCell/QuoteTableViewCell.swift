//
//  ReactTableViewCell.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    var viewModel:QuoteCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension QuoteTableViewCell {
    func configure(with viewModel:QuoteCellViewModel) {
        self.viewModel = viewModel
        quoteLabel.text = viewModel.quote.quote ?? ""
        authorLabel.text = viewModel.quote.author ?? ""
    }
}

extension QuoteTableViewCell {
    public static var cellId: String {
        return "QuoteCell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: QuoteTableViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: QuoteTableViewCell.cellId, bundle: QuoteTableViewCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(QuoteTableViewCell.nib, forCellReuseIdentifier: QuoteTableViewCell.cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> QuoteTableViewCell? {
        if let cell = bundle.loadNibNamed(QuoteTableViewCell.cellId, owner: owner, options: nil)?.first as? QuoteTableViewCell {
            return cell
        } else {
            return nil
        }
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with quoteCellViewModel: QuoteCellViewModel) -> QuoteTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.cellId, for: indexPath) as? QuoteTableViewCell
        cell?.configure(with: quoteCellViewModel)
        return cell!
    }
}
