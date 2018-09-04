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

    func fillInfo() {
        quoteLabel.text = viewModel.quote.quote ?? ""
        authorLabel.text = viewModel.quote.author ?? ""

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
