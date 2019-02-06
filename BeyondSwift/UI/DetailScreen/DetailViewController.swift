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
    @IBOutlet weak var topImage: UIImageView!
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
        preSetupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        navigationCoordinator?.movingBack()
    }
    
    func preSetupView() {
        descriptionTextView.text = viewModel.quote.quote
        descriptionTextView.sizeToFit()
        descriptionTextView.layoutIfNeeded()
        authorLabel.text = "\(viewModel.quote.author!)"
    }
    
    func setupView() {
        let image = (UIImage(named: "\((viewModel.quote.author ?? "Other"))") ?? UIImage(named: "Other")!)
        topImage.image = image
        self.view.backgroundColor = UIColor(red: 0/255, green: 18/255, blue: 29/255, alpha: 1)
        let gradient = CAGradientLayer()
        gradient.frame = topImage.bounds
        let color1 = UIColor(red: 0/255, green: 18/255, blue: 29/255, alpha: 1).cgColor
        gradient.colors = [color1, UIColor.clear.cgColor]
        gradient.endPoint = CGPoint(x: 0.5, y: 0.7)
        gradient.startPoint = CGPoint(x: 0.5, y: 1)
        topImage.layer.insertSublayer(gradient, at: 0)
        
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
