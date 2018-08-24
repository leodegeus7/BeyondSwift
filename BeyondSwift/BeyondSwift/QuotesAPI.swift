//
//  JokesAPI.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 22/08/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import ObjectMapper

class QuotesAPI: NSObject {
    func fetchPopularPhoto( complete: @escaping (_ quotes: [Quote]?, _ error: Error? ) -> Void ) {
        DispatchQueue.global().async {
            let urlAux = URL(string: "https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=10")
            guard let url = urlAux else {
                return
            }
            var request = URLRequest(url: url)
            request.addValue("KI4KhZYbDamshdWyabQwzddNJRBfp1ox6kejsn3srMxYXfM5ay", forHTTPHeaderField: "X-Mashape-Key")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            let session = URLSession.shared
            let tache = session.dataTask(with: request, completionHandler: { (data, _, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let quotes = Mapper<Quote>().mapArray(JSONObject: json)
                        complete(quotes,error)
                    } catch let error {
                        complete(nil,error)
                    }
                } else {
                    print("Error")
                    complete(nil,error)
                }
            })
            tache.resume()
        }
    }
}
