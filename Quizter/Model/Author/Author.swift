//
//  Author.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

/// **** Author ****
class Author: NSObject {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    internal var name: String! {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    
    internal var quotes: [Quote]? {
        get {
            return _quotes
        } set {
            _quotes = newValue
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var _name: String!
    private var _quotes: [Quote]?
    
    // MARK: -
    // MARK: Constructors
    
    init(name: String, quotes: [Quote]?) {
        super.init()
        _name = name
        _quotes = quotes
    }
    
    // MARK: -
    // MARK: Override Base
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    
    // MARK: -
    // MARK: Actions && Selectors
    
}