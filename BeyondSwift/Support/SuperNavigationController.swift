//
//  SuperNavigationController.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 06/02/19.
//  Copyright © 2019 Leonardo Geus. All rights reserved.
//

import UIKit

class SuperNavigationController: UINavigationController {
    override func viewDidLoad() {
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.barTintColor = UIColor(red: 0/255, green: 18/255, blue: 29/255, alpha: 1)
        let attr = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationBar.titleTextAttributes = attr
        self.navigationBar.largeTitleTextAttributes = attr
    }
}
