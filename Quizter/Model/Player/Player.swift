//
//  Player.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/14/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

class Player: NSObject {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    internal var nickname: String? {
        get {
            return _nickname
        } set {
            _nickname = newValue
        }
    }
    
    internal var score: Int? {
        get {
            return _score
        } set {
            _score = newValue
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var _nickname: String?
    private var _score: Int?
    
    // MARK: -
    // MARK: Constructors
    
    init(nickname: String, score: Int) {
        super.init()
        _nickname = nickname
        _score = score
    }
}