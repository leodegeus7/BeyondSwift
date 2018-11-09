//
//  APIQuotesTest.swift
//  BeyondSwiftTests
//
//  Created by Leonardo Geus on 18/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import BeyondSwift

class APIQuotesTests: QuickSpec {
    
    override func spec() {
        
        describe("teste da API Quotes") {  //Describe exactly describes what component you are testing
            
            let api = APIQuotesImpl()
            
            context("que depois de solicitado") {  //Context describes the purpose of the test or the current state of an object.
                it("deve me trazer mais de um quote") { //It describes the expected result of the test.
                    waitUntil(timeout: 5.0, action: { (done) in
                        api.getQuotes(completion: { (quotes) in
                            expect(quotes.count).to(beGreaterThan(0))
                            done()
                        })
                    })
                }
                
                it("deve trazer 100 quotes") {
                    waitUntil(timeout: 5.0, action: { (done) in
                        api.getQuotes(completion: { (quotes) in
                            expect(quotes.count).to(equal(100))
                            done()
                        })
                    })
                }
            }
            
            context("que deve ter quotes com informações relevantes") {
                waitUntil(timeout: 5.0, action: { (done) in
                    api.getQuotes(completion: { (quotes) in
                        let first = quotes[0]
                        
                        it("com um autor não sendo nulo") {
                            expect(first.author).toNot(equal(""))
                        }
                        
                        it("com uma frase existindo") {
                            expect(first.quote).toNot(beNil())
                        }
                        it("com uma frasenão sendo nula") {
                            expect(first.quote).toNot(equal(""))
                        }
                        
                        done()
                    })
                })
            }
        }
    }
}
