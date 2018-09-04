//
//  APIQuotes.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class APIQuotes {

    init() {
    }

    func getQuotes(completion: @escaping (_ result: [Quote]) -> Void) {
        Alamofire.request("https://talaikis.com/api/quotes/").responseJSON { (response) in
            if let json = response.result.value {
                let quotes = Mapper<Quote>().mapArray(JSONObject: json)
                if let quotes = quotes {
                    completion(quotes)
                } else {
                    completion([])
                }
            } else {
                completion([])
            }
        }
    }
}
