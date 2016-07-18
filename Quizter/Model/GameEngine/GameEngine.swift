    //
//  GameEngine.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import Foundation

class GameEngine: NSObject {
    
    // MARK: -
    // MARK: Static Declaration
    
    private let BOOL_GENERATOR_RANGE: Int = 3
    
    // MARK: -
    // MARK: Public Interface
    
    internal weak var delegate: GameDelegate?
    
    // MARK: -
    // MARK: Private Interface
    
    private var gameMode: GameMode!
    private var dataSource: [Author] = DataSource.get()
    private var defaults: NSUserDefaults {
        get {
            return NSUserDefaults.standardUserDefaults()
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    init(delegate: GameDelegate, gameMode: GameMode) {
        super.init()
        self.delegate = delegate
        self.gameMode = gameMode
    }
    
    // MARK: -
    // MARK: Override Base
    
    // MARK: -
    // MARK: Public Implementation

    /**
     Return random quote and author
     
     - returns: Tuple of (Author, Quote)
     */
    internal func getQuote() -> ([Author], Quote)? {
                
        if self.dataSource.count == 0 {
            /**
              *  Delegation, Inform QuizViewController for game ending
              */
            return nil
        }
        
        /// Represend generated index for author
        var aIndex: Int!
        /// Represend generated index for quote
        var qIndex: Int!
        /// Represend choosed author
        var author: [Author] = []
        /// Represend choosed quote
        var quote: Quote!

        // Generate number in range 0...authors.count
        aIndex = generateRandomNumber(dataSource.count)
        // Check if author has quotes left
        if dataSource[aIndex].quotes!.count == 0 {
            /**
             *  If author has no more quotes remove it from authors array
             */
            removeAuthorAt(aIndex)
            // Return nil
            return nil
        } else {
            // Generate number in range 0...author.quotes.count
            qIndex = generateRandomNumber(dataSource[aIndex].quotes!.count)
            // Set the quote
            quote = dataSource[aIndex].quotes![qIndex]

            if self.gameMode == GameMode.Binary {
                /**
                 *  Generate bool value form integer 0/1 to decide whether to change the selected author, or stick with the choosen one.
                 */
                if generateRandomNumber(BOOL_GENERATOR_RANGE).boolValue() {
                    // If true get new authorIndex
                    aIndex = generateRandomNumber(dataSource.count)
                }
            } else {
                // We do - 1 beacause we already have one author
                while author.count < NumberOfGuessesInMultipliMode - 1{
                    // Check if we have enough authors
                    if dataSource.count < NumberOfGuessesInMultipliMode {
                        // Inform game for ending
                        delegate?.applicationHasNoMoreQuotes!()
                        // End loop
                        break
                    }

                    // Get random authors
                    let randomAuthorIndex = generateRandomNumber(dataSource.count)
                    // Check if author is same
                    if randomAuthorIndex != aIndex {
                        author.append(dataSource[randomAuthorIndex])
                    }
                }
            }
            
            // Set the author
            author += [dataSource[aIndex]]
        }
        
        if gameMode == GameMode.Multipli {
            // Shufle authors if game mode is multi question
            shuffleArray(&author)
        }
        
        /**
         Return author and quote
         */
        return (author, quote)
    }
    
    /**
     Remove Quote from author quotes array
     
     - parameter quote: Quote
     */
    internal func removeQuote(quote: Quote) {
        for author in dataSource {
            for (index, currentQuote) in author.quotes!.enumerate() {
                if currentQuote.text == quote.text {
                    author.quotes?.removeAtIndex(index)
                }
            }
        }
    }
    
    /**
     Retrieve all player scores
     
     - returns: [[String : AnyObject]]
     */
    internal func overallPlayerScores() -> [[String : AnyObject]] {
        if defaults.objectForKey("overall_scores") == nil {
            // There are no results
            return [[String: AnyObject]]()
        } else {
            return defaults.objectForKey("overall_scores") as! [[String: AnyObject]]
        }
    }
    
    /**
     Save new score
     
     - parameter nickname: String
     - parameter score: Int
     */
    internal func savePlayerScore(nickname: String, score: Int) {
        
        var _nickname: String?
        
        // Create top scorer result
        if nickname == "" {
            _nickname = "no-name"
        } else {
            _nickname = nickname
        }
        
        let newScore: [String: AnyObject] = ["name" : _nickname!, "score" : score]
        // Save to user defaults
        
        if defaults.objectForKey("overall_scores") == nil {
            // Create scores array
            let scores: [[String : AnyObject]] = [newScore]
            // Add new
            defaults.setObject(scores, forKey: "overall_scores")
        } else {
            // Get old scores
            var scores = defaults.objectForKey("overall_scores") as! [[String : AnyObject]]
            // Add new
            scores += [newScore]
            // Set 
            defaults.setObject(scores, forKey: "overall_scores")
        }
        
        // Sync
        defaults.synchronize()
    }
    
    
    
    // MARK: -
    // MARK: Private Implementation
    
    /**
     Remove author
     
     - parameter index: Int
     */
    private func removeAuthorAt(index: Int) {
        // Remove element from dataSource at index
        dataSource.removeAtIndex(index)
        if dataSource.count == 0 {
            // Last author was removed send message to Game object
            delegate?.applicationHasNoMoreQuotes!()
        }
    }
    
    /**
     Remove quote
     
     - parameter index: Int
     */
    private func removeQuoteAt(index: Int) {
        
    }
    
    /**
     Generate random number for given range
     
     - parameter maxRange: Int
     
     - returns: Int
     */
    private func generateRandomNumber(maxRange: Int) -> Int {        
        return Int(arc4random_uniform(UInt32(maxRange - 1)))
    }
    
    /**
     Shuffle indexex in array
     
     - parameter array: [Author]
     
     - returns: [Author]
     */
    private func shuffleArray(inout array: [Author]) -> [Author] {
        
        /**
         *  Shuffle authors
         */
        for index in 0..<array.count {
            let firstRand = self.generateRandomNumber(array.count)
            // Swap pointers
            if index != firstRand {
                swap(&array[index], &array[firstRand])
            }
            
            // Get 50% chance
            if generateRandomNumber(BOOL_GENERATOR_RANGE).boolValue() {
                /**
                 * Every time we swap the last element with one of the first two until the loop is done
                 */
                let secondRand = generateRandomNumber(BOOL_GENERATOR_RANGE)
                if secondRand != array.count - 1 {
                    swap(&array[array.count - 1], &array[secondRand])
                }
            }
        }
        
        return array
    }
    
    // MARK: -
    // MARK: Actions && Selectors
    
}
