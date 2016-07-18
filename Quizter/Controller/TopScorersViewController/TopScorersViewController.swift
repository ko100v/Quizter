//
//  TopScorersViewController.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/18/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class TopScorersViewController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    internal var game: Game!
    internal var delegate: GameModeDelegate?
    
    // MARK: -
    // MARK: Private Interface
    
    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = AppColor.darkPurpleColor()
            tableView.separatorColor = AppColor.darkPurpleColor()
            view.addSubview(tableView)
        }
    }
    
    private var overallScores: [[String : AnyObject]]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    init(game: Game, delegate: GameModeDelegate) {
        super.init(nibName: nil, bundle: nil)
        // Set game
        self.game = game
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Update UI
        if game.didEnd {
            updateUI()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        /**
         Configuration
         */
        view.backgroundColor = AppColor.darkPurpleColor()
        
        /**
         Initialization
         */
        tableView = UITableView()
        // Get player
        overallScores = game.overallScores
    }
    
    
    override func layoutUI() {
        super.layoutUI()
        tableView.frame = CGRectMake(0, BS.StatusBarHeight, view.frame.size.width, view.frame.size.height - BS.StatusBarHeight)
    }
    
    override func updateUI() {
        super.updateUI()
        
        // Create form
        let alertController = UIAlertController(title: "Enter Nickname", message: nil, preferredStyle: .Alert)
        let doneAction = UIAlertAction(title: "Done", style: .Default) { (_) in
            // Set nickname
            self.game.player?.nickname = alertController.textFields!.first!.text
            // Save
            self.game.setPlayerScore()
            // Reload table
            self.overallScores = self.game.overallScores
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Nickname"
            textField.borderStyle = .RoundedRect
        }
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        // Present
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation

    
    // MARK: -
    // MARK: Actions && Selectors
    
    // MARK: -
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1;
        case 1:
            return overallScores != nil ? overallScores.count : 0
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell(style: .Value1, reuseIdentifier: CellIdentifiers.DefaultCellId)
        cell.selectionStyle = .None
        
        if indexPath.section == 0 {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifiers.DefaultCellId)
            cell.textLabel?.text = game.didEnd ? "New Game" : "Back"
            cell.textLabel?.textColor = .whiteColor()
            cell.textLabel?.textAlignment = .Center
            cell.backgroundColor = game.didEnd ? AppColor.greenColor() : AppColor.redColor()
            return cell
        }
        
        let playerScore = overallScores[indexPath.row]
        cell.textLabel?.text = playerScore["name"] as? String
        cell.textLabel?.textColor = AppColor.darkPurpleColor()
        cell.detailTextLabel?.text = "\(playerScore["score"] as! Int)"
        cell.detailTextLabel?.textColor = AppColor.redColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "New Game"
        case 1:
            return "Ranking"
        default:
            return ""
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // Change header view title color
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if game.didEnd {
                    delegate?.playerDidChange(game.gameMode)
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
