//
//  ReactViewModel.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import RxSwift
import RxCocoa

class ReactViewModel: NSObject {

    var quotes = Variable<[Quote]>([])

    init(api:APIQuotes) {
        super.init()
        api.getQuotes { (quotes) in
            self.quotes.value = quotes
        }
    }
}
