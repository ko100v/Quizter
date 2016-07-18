//
//  SettingsView.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/15/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

/**
 *  **** GameModeDelegate ****
 */
protocol GameModeDelegate {
    
    /**
     Emits when player change game mode
     */
    func playerDidChange(gameMode: GameMode)
    
    /**
     Emits when player wants to see topscorers
     */
    func showTopScorers()
}

class SettingsView: UIView, UITableViewDelegate, UITableViewDataSource, GameModeDelegate {

    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    private var delegate: GameModeDelegate?
    private var gameMode: GameMode? {
        didSet {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
            cell!.detailTextLabel?.text = self.gameMode?.toString()
            cell?.layoutIfNeeded()
        }
    }
    
    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = AppColor.darkPurpleColor()
            tableView.registerClass(GameModeTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.GameModeCellID)
            tableView.bounces = false
            tableView.separatorColor = AppColor.darkPurpleColor()
            addSubview(tableView)
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, delegate: GameModeDelegate?, gameMode: GameMode) {
        super.init(frame: frame)
        self.delegate = delegate
        self.gameMode = gameMode
        
        // Always Call setupUI
        setupUI()
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /**
         Layout && Geometry
         */
        tableView.frame = bounds
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    
    /**
     Initialization && Configuration
     */
    private func setupUI() {
        
        /**
         Configuration
         */
        
        /**
         Initialization
         */
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        
    }
    
    // MARK: -
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifiers.DefaultCellId)
        cell.selectionStyle = .None
        
        switch indexPath.row {
        case 0:
            let cell = GameModeTableViewCell(style: .Subtitle, reuseIdentifier: CellIdentifiers.GameModeCellID, delegate: self, gameMode: self.gameMode!)
            cell.textLabel?.text = "Game Mode"
            cell.detailTextLabel?.text = self.gameMode?.toString()
            return cell
        case 1:
            cell.textLabel?.text = "Best Scores"
            cell.accessoryType = .DetailDisclosureButton
            cell.tintColor = AppColor.darkPurpleColor()
        case 2:
            cell.textLabel?.text = "New Game"
            cell.textLabel?.textColor = .whiteColor()
            cell.textLabel?.textAlignment = .Center
            cell.backgroundColor = AppColor.greenColor()
        default: break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        // Change header view title color
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            /**
             Delegation
             */
            delegate?.playerDidChange(self.gameMode!)
        } else if indexPath.row == 1 {
            /**
             Delegation
             */
            delegate?.showTopScorers()
        }
    }
    
    // MARK: -
    // MARK: GameModeDelegate 
    
    func playerDidChange(gameMode: GameMode) {
        self.gameMode = gameMode
        delegate?.playerDidChange(gameMode)
    }
    
    func showTopScorers() {
        // Empty Implementation
    }
}


/// **** GameModeTableViewCell ****
class GameModeTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    private var delegate: GameModeDelegate?
    private var gameMode: GameMode?
    private var gameModeSwitch: UISwitch! {
        didSet {
            gameModeSwitch.addTarget(self, action: #selector(gameModeSwitchChanged(_:)), forControlEvents: .ValueChanged)
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, delegate: GameModeDelegate, gameMode: GameMode) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.delegate = delegate
        self.gameMode = gameMode
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func drawRect(rect: CGRect) {
        selectionStyle = .None
        gameModeSwitch = UISwitch()
        gameModeSwitch.setOn((gameMode?.toBool())!, animated: true)
        accessoryView = gameModeSwitch
        
        detailTextLabel?.textColor = AppColor.redColor()
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    
    
    // MARK: -
    // MARK: Actions && Selectors
    
    func gameModeSwitchChanged(sender: UISwitch) {
        /**
         *  Delegation
         */
        self.gameMode?.toBool() == true ? (self.gameMode = .Binary) : (self.gameMode = .Multipli)
        gameModeSwitch.setOn((self.gameMode?.toBool())!, animated: true)
        delegate?.playerDidChange(self.gameMode!)
    }
    
}

