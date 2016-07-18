//
//  QuizViewController.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

import UIKit

class QuizViewController: BaseController, GameDelegate, GameModeDelegate, AnswerDelegate {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    private var game: Game!
    
    private var _currentQuote: ([Author], Quote)? {
        didSet {
            if game.gameMode == GameMode.Binary {
                quoteView?.toBinaryView().authorName = _currentQuote!.0.first!.name
                quoteView?.toBinaryView().quoteText = _currentQuote!.1.text
            } else {
                // Reload table
                quoteView?.quoteText = _currentQuote?.1.text
                quoteView?.toMultiView().authors = _currentQuote!.0
            }
        }
    }
    
    private var currentQuote: ([Author], Quote)? {
        get {
            return _currentQuote
        } set {
            if newValue == nil {
                if !game.didEnd {
                    // If there is quotes left keep getting
                    self.currentQuote = game.newQuote
                }
            } else {
                _currentQuote = newValue
            }
        }
    }
    
    @IBOutlet weak var segmentControll: UISegmentedControl!

    private var settingsView: SettingsView? {
        didSet {
        }
    }
    
    private var quoteView: BaseQuoteView? {
        didSet {
            currentQuote = game.newQuote
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    // MARK: -
    // MARK: ViewController LifeCycle
    
    // MARK: -
    // MARK: Override Base
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /**
         *  Layout && Geometry
         */
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    /**
     Initialization && Configuration
     */
    override func setupUI() {
        super.setupUI()
        
        /**
         Create new game
         */
        game = Game()
        game.delegate = self
    }
    
    /**
     Update UI related elements
     */
    override  func updateUI() {
        super.updateUI()
    }
    
    /**
     Layout UI related elements
     */
    override  func layoutUI() {
        super.layoutUI()
        
        quoteView?.frame = CGRect(x: 0, y: segmentControll.frame.maxY, width: view.frame.size.width, height: view.frame.size.height - segmentControll.frame.maxY)
    }
    
    /**
     Clear UI related elements
     */
    override  func clearUI() {
        super.clearUI()
        
    }
    
    // MARK: -
    // MARK: Private Implementation
    
    /**
     Changes top buttons states
     */
    
    // MARK: -
    // MARK: Actions && Selectors
    
    @IBAction func onSegmentChange(sender: UISegmentedControl) {
        
        sender.userInteractionEnabled = false
        
        if segmentControll.selectedSegmentIndex == 0 {
            // Animate
            UIView.animateWithDuration(0.5, animations: { 
                self.settingsView?.frame = CGRectMake(self.view.frame.size.width, self.settingsView!.frame.origin.y, self.settingsView!.frame.size.width, self.settingsView!.frame.size.height)
                }, completion: { (_) in
                    self.settingsView?.removeFromSuperview()
                    self.settingsView = nil
                    sender.userInteractionEnabled = true
            })

        } else {
            
            // Init with frame
            settingsView = SettingsView(frame: CGRectMake(view.frame.size.width, quoteView!.frame.origin.y, view.frame.size.width, quoteView!.frame.size.height), delegate: self, gameMode: game.gameMode)
            
            // Add as subview
            view.addSubview(settingsView!)
            
            // Animate
            UIView.animateWithDuration(0.5, animations: {
                self.settingsView?.frame = CGRectMake(0, self.settingsView!.frame.origin.y, self.settingsView!.frame.size.width, self.settingsView!.frame.size.height)
                }, completion: { (_) in
                    sender.userInteractionEnabled = true
            })
        }
    }
    
    // MARK: -
    // MARK: GameDelegate
    
    func applicationDidFinishConfigurationFor(game: Game) {
        /**
         Data Source is ready
         */
        switch game.gameMode! {
        case GameMode.Binary: quoteView = BinaryQuoteView()
        case GameMode.Multipli: quoteView = MultiQuoteView()
        }
        quoteView!.delegate = self
        view.addSubview(quoteView!)
    }
    
    func applicationHasNoMoreQuotes() {
        // Present top scorers view controller
        let topScorersViewController = TopScorersViewController(game: game, delegate: self)
        self.presentViewController(topScorersViewController, animated: true, completion: nil)
    }
    
    func applicationDidChangeGameMode() {
        // GameModeChanged
        
        quoteView?.removeFromSuperview()
        switch game.gameMode! {
        case GameMode.Binary: quoteView = BinaryQuoteView()
        case GameMode.Multipli: quoteView = MultiQuoteView()
        }
        
        quoteView!.delegate = self
        if settingsView != nil {
            view.insertSubview(quoteView!, belowSubview: settingsView!)
        } else {
            view.addSubview(quoteView!)
        }
    }
    
    // MARK: - 
    // MARK: GameModeDelegate
    
    func playerDidChange(gameMode: GameMode) {
        // Set new game mode
        if self.game.gameMode == gameMode {
            // Programatically change views
            segmentControll.selectedSegmentIndex = 0
            onSegmentChange(segmentControll)
        }
        // Start new game
        game.newGame(gameMode)
    }
    
    func showTopScorers() {
        let topScorersViewController = TopScorersViewController(game: game, delegate: self)
        self.presentViewController(topScorersViewController, animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: BaseQuoteViewDelegate
    
    func playerDidAnswer(value: Bool) {
        
        if game.checkAnswer(currentQuote!.1, author: currentQuote!.0.first!, value: value) {
            game.updatePlayerScore()
            quoteView?.playerScore = game.getPlayerScore()
            Toast.show(true)
        } else {
            Toast.show(false)
        }

        currentQuote = game.newQuote
    }
    
    func playerDidChoseAuthor(author: Author) {
        
        if game.checkAnswer(currentQuote!.1, author: author, value: nil) {
            game.updatePlayerScore()
            quoteView?.playerScore = game.getPlayerScore()
            Toast.show(true)
        } else {
            Toast.show(false)
        }
        
        currentQuote = game.newQuote
    }
}