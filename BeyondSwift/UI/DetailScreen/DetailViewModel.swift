//
//  DetailViewModel.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 08/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

class DetailViewModel: NSObject {

    var quote:Quote
    
    init(with quote: Quote) {
        self.quote = quote
    }
    
}
