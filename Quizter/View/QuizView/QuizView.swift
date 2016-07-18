//
//  QuizView.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class QuizView: UITableView, UITableViewDelegate, UITableViewDataSource, AnswerTableViewCellDelegate {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    private var game: Game!
    
    private var _currentQuote: (Author, Quote)? {
        didSet {
            // Every time when currentQuote is set reloadData
            reloadData()
        }
    }
    
    private var currentQuote: (Author, Quote)? {
        get {
            return _currentQuote
        } set {
            if newValue == nil {
                if !game.didEnd {
                    self.currentQuote = game.newQuote
                }
            } else {
                _currentQuote = newValue
            }
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        // Always call setpUI on initialization
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Always call setpUI on initialization
        setupUI()
    }
    
    init(game: Game) {
        super.init(frame: CGRectZero, style: .Plain)
        self.game = game
        
        // Always call setpUI on initialization
        setupUI()
    }
    
    // MARK: -
    // MARK: Override Base
    
    // MARK: -
    // MARK: Public Implementation
    
    /**
     Set new game, emits when player change game mode
     
     - parameter game: Game
     */
    internal func setGame(game: Game) {
        self.game = game
        reloadData()
    }
    
    // MARK: -
    // MARK: Private Implementation
    
    /**
     Initialization && Configuration
     */
    private func setupUI() {
        
        /**
         *  Configuration
         */
        delegate = self
        dataSource = self
        bounces = false
        separatorColor = .whiteColor()
        registerClass(AnswerTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.AnswerCellId)
        
        // Get random queue
        self.currentQuote = game.newQuote
    }
    
    // MARK: -
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifiers.DefaultCellId)
        cell.selectionStyle = .None
        
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Who Said It?"
            cell.textLabel?.textColor = .lightGrayColor()
        } else if indexPath.row == 1 {
            cell.textLabel?.text = currentQuote!.1.text
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .ByWordWrapping
            cell.textLabel?.sizeToFit()
        } else {
            if game.gameMode == GameMode.Binary {
                if indexPath.row == 2 {
                    cell.textLabel?.text = "\(currentQuote!.0.name) \(currentQuote!.0.quotes?.count)"
                    cell.textLabel?.textAlignment = .Center
                } else {
                    return AnswerTableViewCell(style: .Default, reuseIdentifier: CellIdentifiers.AnswerCellId, delegate: self)
                }
            } else {
                cell.textLabel?.text = currentQuote!.0.name
                cell.textLabel?.textAlignment = .Center

            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: return BS.ButtonHeight
        case 1: return UITableViewAutomaticDimension
        case 3: return BS.ButtonHeight
        default:
            return BS.ButtonHeight
        }
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: -
    // MARK: AnswerTableViewCellDelegate
    
    func playerDidAnswer(value: Bool) {
        // Check answer
        if game.checkAnswer(currentQuote!.1, author: currentQuote!.0, value: value) {
            // Update player scor
            game.updatePlayerScore()
        }
        // Get new quote
        currentQuote = game.newQuote
    }
}

