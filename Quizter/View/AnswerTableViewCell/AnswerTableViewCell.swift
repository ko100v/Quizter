//
//  AnswerTableViewCell.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/14/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

/**
 *  **** AnswerTableViewCellDelegate ****
 */
protocol AnswerTableViewCellDelegate {
    
    /**
     Emits when playe pres eather yes or no button for answer
     
     - parameter value: Bool
     */
    func playerDidAnswer(value: Bool)
    
}

class AnswerTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface

    // MARK: -
    // MARK: Private Interface
    
    private var delegate: AnswerTableViewCellDelegate?
    
    private var yesButton: UIButton! {
        didSet {
            yesButton.setTitle("Yes", forState: .Normal)
            yesButton.setTitleColor(.whiteColor(), forState: .Normal)
            yesButton.backgroundColor = .greenColor()
            yesButton.addTarget(self, action: #selector(yesButtonPressed(_:)), forControlEvents: .TouchUpInside)
            addSubview(yesButton)
        }
    }
    
    private var noButton: UIButton! {
        didSet {
            noButton.setTitle("No", forState: .Normal)
            noButton.setTitleColor(.whiteColor(), forState: .Normal)
            noButton.backgroundColor = .redColor()
            noButton.addTarget(self, action: #selector(noButtonPressed(_:)), forControlEvents: .TouchUpInside)
            addSubview(noButton)
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Always call setupUI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Always call setupUI
        setupUI()
    }

    init(style: UITableViewCellStyle, reuseIdentifier: String?, delegate: AnswerTableViewCellDelegate) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.delegate = delegate
        
        // Always call setupUI
        setupUI()
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /**
         Layout && Geometry
         */
        yesButton.frame = CGRectMake(0, 0, frame.size.width / 2, frame.size.height)
        noButton.frame = CGRectMake(yesButton.frame.maxX, 0, frame.size.width / 2, frame.size.height)
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
        selectionStyle = .None
        /**
         Initialization
         */
        yesButton = UIButton()
        noButton = UIButton()
    }
    
    // MARK: -
    // MARK: Actions && Selectors
    
    func yesButtonPressed(sender: UIButton) {
        /**
         Delegation
         */
        delegate?.playerDidAnswer(true)
    }
    
    func noButtonPressed(sender: UIButton) {
        /**
         Delegation
         */
        delegate?.playerDidAnswer(false)
    }
    
}
