//
//  DetailViewController.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 08/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    fileprivate var viewModel: DetailViewModel!
    fileprivate weak var navigationCoordinator: NavigationCoordinator?

    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            navigationCoordinator?.movingBack()
        }
    }
    
    func configure(with viewModel: DetailViewModel,
                   navigationCoordinator: NavigationCoordinator) {
        self.viewModel = viewModel
        self.navigationCoordinator = navigationCoordinator
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil!, bundle: nibBundleOrNil)
        self.title = "Quotes"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        descriptionTextView.text = viewModel.quote.quote
        authorLabel.text = " -- \(viewModel.quote.author!)"
    }
}
