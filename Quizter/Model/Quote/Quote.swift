//
//  Quote.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

/// **** Quote **** 
class Quote: NSObject {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    internal var text: String! {
        get {
            return _text
        } set {
            _text = newValue
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var _text: String!
    
    // MARK: -
    // MARK: Constructors
    
    init(text: String) {
        super.init()
        _text = text
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