//
//  Game.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

/**
 *  **** GameDelegate ****
 */
@objc protocol GameDelegate: class {
    
    /**
     Callback when datasource is full with quotes and authros
     */
    optional func applicationDidFinishConfigurationFor(game: Game)
    
    optional func applicationHasNoMoreQuotes()
    
    optional func applicationDidChangeGameMode()
}

class Game: NSObject, GameDelegate {
    
    // MARK: -
    // MARK: Static Declaration
    
    
    // MARK: -
    // MARK: Public Interface
    
    internal weak var delegate: GameDelegate? {
        didSet {
            /**
             *  Build data base
             */
            buildDataSource()
        }
    }
    
    // Current player
    internal var player: Player?
    // Game Mode
    internal var gameMode: GameMode! {
        didSet {
            // Game mode has changed
            delegate?.applicationDidChangeGameMode!()
        }
    }
    // Data source
    internal var authors: [Author]!
    // New quote tuple (Author, Quote)
    internal var newQuote: ([Author], Quote)? {
        get {
            return gameEngine.getQuote()
        }
    }
    // Game edning
    internal var didEnd: Bool = false
    
    // Overall player scores
    internal var overallScores: [[String: AnyObject]]? {
        get {
            return gameEngine.overallPlayerScores().sort({ ($0["score"] as! Int) > ($1["score"] as! Int) })
        }
    }

    // MARK: -
    // MARK: Private Interface
    
    // Game engine + logic
    private var gameEngine: GameEngine!
    
    // MARK: -
    // MARK: Constructors
    
    override init() {
        super.init()
        
        /**
         Initialization
         */
        player = Player(nickname: "", score: 0)
        gameMode = GameMode()
        gameEngine = GameEngine(delegate: self, gameMode: gameMode)
    }
    
    // MARK: -
    // MARK: Override Base
    
    // MARK: -
    // MARK: Public Implementation
    
    
    /**
     Check if player guess is correct
     
     - parameter quote:  Quote
     - parameter author: Author
     - parameter value:  Bool
     
     - returns: Bool
     */
    internal func checkAnswer(quote: Quote, author: Author, value: Bool?) -> Bool {
        
        
        if gameMode == GameMode.Binary {
            /**
            * Simply filter the array if there is results author for sure has said this quote and return true otherwise return false depends on player answer
            */
            if !author.quotes!.filter( { $0.text == quote.text }).isEmpty {
                
                // Remove quote
                gameEngine.removeQuote(quote)
                
                return value!
            } else {
                // Remove quote
                gameEngine.removeQuote(quote)
                
                return !value!
            }
            
            /**
            return !author.quotes!.filter({ $0.text == quote.text }).isEmpty ? value! ? true : false : value! ? true : false
            */
            
        } else {
            // Loop through all authors quotes if there is one return true otherwise false
            if !author.quotes!.filter({ $0.text == quote.text }).isEmpty {
                // Remove quote
                gameEngine.removeQuote(quote)
                
                return true
            } else {
                // Remove quote
                gameEngine.removeQuote(quote)
                
                return false
            }
            /**
            return !author.quotes!.filter({ $0.text == quote.text }).isEmpty ? true : false
            */
        }
    }
    
    /**
     Increment player score for correct answer
     */
    internal func updatePlayerScore() {
        player?.score! += 1
    }
    
    /**
     Creates new game
     */
    internal func newGame(gameMode: GameMode) {
        // Build new data
        gameEngine = GameEngine(delegate: self, gameMode: gameMode)
        // Set new gameMode
        self.gameMode = gameMode
        // Create new player
        player = Player(nickname: "", score: 0)
        // Enable game
        didEnd = false
    }
    
    /**
     Returns player score
     
     - returns: Int
     */
    internal func getPlayerScore() -> Int {
        return player!.score!
    }
    
    /**
     Save player data
     
     - parameter player: Player
     */
    internal func setPlayerScore() {
        gameEngine.savePlayerScore(player!.nickname!, score: player!.score!)
    }
    
    // MARK: -
    // MARK: Private Implementation
    
    /**
     Create data source and fill quotes and authors array
     */
    private func buildDataSource() {
        
        /**
         *  Delegation
         */
        delegate?.applicationDidFinishConfigurationFor!(self)
    }
    
    // MARK: -
    // MARK: Actions && Selectors
    
    // MARK: -
    // MARK: GameDelegate
    
    func applicationHasNoMoreQuotes() {
        // Turn flag for game ending
        didEnd = true
        /**
            Inform QuizViewController for game ending
        */
        delegate?.applicationHasNoMoreQuotes!()
    }
    
}

// MARK: - Integer Extensions
extension Int {
    
    /**
     Convert Int to bool if integer is in range 0..1
     
     - returns: Bool
     */
    func boolValue() -> Bool {
        switch self {
        case 0: return false
        case 1: return true
        default: print("There is an error while generating random number"); return false
        }
    }
}