//
//  ReactTableViewCell.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

class Quote2TableViewCell: UITableViewCell {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var imageAuthorView: UIImageView!
    
    var viewModel:Quote2CellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
}

extension Quote2TableViewCell {
    func configure(with viewModel:Quote2CellViewModel) {
        self.viewModel = viewModel
        quoteLabel.text = viewModel.quote.quote ?? ""
        authorLabel.text = viewModel.quote.author ?? ""
        topView.layer.cornerRadius = 10
        topView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        self.backgroundColor = UIColor(red: 0/255, green: 18/255, blue: 29/255, alpha: 1)
        backView.backgroundColor = UIColor(red: 0/255, green: 45/255, blue: 71/255, alpha: 1)
        
        DispatchQueue.main.async {
            let image = (UIImage(named: "\((viewModel.quote.author ?? "Other"))") ?? UIImage(named: "Other")!)//.multiply(color: UIColor(red: 0, green: 116/255, blue: 181/255, alpha: 1))
            self.imageAuthorView.image = image
        }
    }
}

extension Quote2TableViewCell {
    public static var cellId: String {
        return "Quote2Cell"
    }
    
    public static var bundle: Bundle {
        return Bundle(for: Quote2TableViewCell.self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: Quote2TableViewCell.cellId, bundle: Quote2TableViewCell.bundle)
    }
    
    public static func register(with tableView: UITableView) {
        tableView.register(Quote2TableViewCell.nib, forCellReuseIdentifier: Quote2TableViewCell.cellId)
    }
    
    public static func loadFromNib(owner: Any?) -> Quote2TableViewCell? {
        if let cell = bundle.loadNibNamed(Quote2TableViewCell.cellId, owner: owner, options: nil)?.first as? Quote2TableViewCell {
            return cell
        } else {
            return nil
        }
    }
    
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with quote2CellViewModel: Quote2CellViewModel) -> Quote2TableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Quote2TableViewCell.cellId, for: indexPath) as? Quote2TableViewCell
        cell?.configure(with: quote2CellViewModel)
        return cell!
    }
}
