//
//  Quote.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import ObjectMapper

class Quote: Mappable {
    var author: String?
    var quote: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        author <- map["author"]
        quote <- map["quote"]
    }
}
