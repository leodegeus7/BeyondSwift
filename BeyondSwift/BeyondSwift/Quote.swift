//
//  Quote.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 22/08/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import ObjectMapper

class Quote : Mappable {
    var quote:String?
    var author:String?
    var category:String?
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        quote <- map["quote"]
        author <- map["author"]
        category <- map["category"]
    }
}
