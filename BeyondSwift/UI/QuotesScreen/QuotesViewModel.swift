//
//  ReactViewModel.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 03/09/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

struct QuoteSection {
    var header: String
    var items: [Item]
}
extension QuoteSection: SectionModelType {
    typealias Item = Quote
    
    init(original: QuoteSection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol ReactViewModel {
    var sections: BehaviorRelay<[QuoteSection]> { get }
    func loadData(finished: @escaping BlockWithSource)
}
 
class ReactViewModelImpl:ReactViewModel {
    var sections = BehaviorRelay<[QuoteSection]>(value: [])
    var quotes = BehaviorRelay<[Quote]>(value: [])
    var apiLayer:APIQuotes
    fileprivate var bag = DisposeBag()
    
    init(apiLayer:APIQuotes) {
        self.apiLayer = apiLayer
        setupObservers()
    }
}

extension ReactViewModelImpl {
    func setupObservers() {
        quotes.asObservable().subscribe { (event) in
            self.updateNewSections(with: event.element!)
        }.disposed(by: bag)
    }
    
    func updateNewSections(with quotes: [Quote]) {
        func mainWork() {
            sections.accept(filter(quotes: quotes))
        }
        
        func filter(quotes: [Quote]) -> [QuoteSection] {
            return [QuoteSection(header: "All", items: quotes)]
        }
        
        mainWork()
    }
}

typealias BlockWithSource = () -> Void
extension ReactViewModelImpl {
    func loadData(finished: @escaping BlockWithSource) {
        apiLayer.getQuotes { (quotes) in
            self.quotes.accept(quotes)
            finished()
        }
    }
}
