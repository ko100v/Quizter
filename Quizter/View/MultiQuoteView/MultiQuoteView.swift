//
//  File.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/18/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class MultiQuoteView: BaseQuoteView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Static Declaration
    
    private let TableViewWidth: CGFloat = 300
    
    // MARK: -
    // MARK: Public Interface
    
    internal var authors: [Author]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = AppColor.greenColor()
            tableView.layer.cornerRadius = 10
            tableView.separatorColor = .whiteColor()
            tableView.bounces = false
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
    
    // MARK: -
    // MARK: Override Base
    
    override func setupUI() {
        super.setupUI()
        
        /**
         Initialization
         */
        tableView = UITableView(frame: CGRectZero, style: .Plain)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.frame = CGRect(x: frame.size.width / 2 - TableViewWidth / 2, y: self.balloonImageViewFrame.maxY + BO.y, width: TableViewWidth, height: 3*BS.ButtonHeight)
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
        return authors != nil ? authors!.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifiers.DefaultCellId)
        cell.clipsToBounds = true
        cell.selectionStyle = .None
        cell.backgroundColor = .clearColor()
        cell.textLabel?.text = authors![indexPath.row].name
        cell.textLabel?.textColor = .whiteColor()
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /**
         *  Delegation
         */
        delegate?.playerDidChoseAuthor!(authors![indexPath.row])
    }
}
