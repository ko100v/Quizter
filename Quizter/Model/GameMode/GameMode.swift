//
//  GameMode.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

/**
 **** GameMode ****
 
 - Binary:   Yes / No answers
 - Multipli: Multipli answers
 */
enum GameMode {
    case Binary
    case Multipli
    
    // MARK: - Constructors
    init() {
        // Always start game with Yes / No mode
        self = .Binary
    }
    
}

// MARK: - GameMode Extensions
extension GameMode {
    
    /**
     Convert enum value of GameMode to Bool
     
     - returns: Bool
     */
    func toBool() -> Bool {
        switch self {
        case .Binary: return false
        case .Multipli: return true
        }
    }
    
    /**
     Convert enum value of GameMode to String
     
     - returns: String
     */
    func toString() -> String {
        switch self {
        case .Binary: return " Yes / No "
        case .Multipli: return " Multipli answers"
        }
    }
    
}