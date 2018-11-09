//
//  QuotesViewControllerTests.swift
//  BeyondSwiftTests
//
//  Created by Leonardo Geus on 18/10/18.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Swinject
@testable import BeyondSwift

class QuotesViewControllerTests: QuickSpec {
    override func spec() {
        
        let string = "{\r\n  \"author\": \"Testador\",\r\n  \"quote\": \"Testando\"\r\n}"
        
        let container = Container()
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistryImpl(container: container)
        }
        let dependencyRegistry: DependencyRegistry = AppDelegate.dependencyRegistry
        
        describe("com a QuotesViewController") {
            let detail = dependencyRegistry.makeDetailViewController(with: Quote(JSONString: string)!)
            context("a controller") {
                waitUntil(timeout: 5.0) { (done) in
                    it("nao sendo nula") {
                        expect(detail).notTo(beNil())
                        done()
                    }
                }
                
            }
        }
        
    }
}
