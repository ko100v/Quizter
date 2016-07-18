//
//  BaseQuoteView.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/16/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

/**
 *  **** AnswerDelegate
 */
@objc protocol AnswerDelegate {
    /**
     Emits when player answer yes no question mode
     
     - parameter value: Bool
     */
    optional func playerDidAnswer(value: Bool)
    
    /**
     Emits when player answer on multi question mode
     
     - parameter author: Author
     */
    optional func playerDidChoseAuthor(author: Author)
}

class BaseQuoteView: UIView {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    internal var delegate: AnswerDelegate?
    
    internal var quoteText: String! {
        didSet {
            initQuoteLabel()
        }
    }
    
    internal var playerScore: Int! {
        didSet {
            playerScoreLabel?.text = "Your Score \(playerScore)"
        }
    }
    
    internal var balloonImageViewFrame: CGRect! {
        get {
            return balloonImageView!.frame
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var whoSaidItLabel: UILabel? {
        didSet {
            whoSaidItLabel?.text = "Who Said It?"
            whoSaidItLabel?.textColor = .whiteColor()
            whoSaidItLabel?.textAlignment = .Left
            addSubview(whoSaidItLabel!)
        }
    }
    
    private var playerScoreLabel: UILabel? {
        didSet {
            playerScoreLabel?.text = "Your Score 0"
            playerScoreLabel?.textColor = .whiteColor()
            playerScoreLabel?.textAlignment = .Right
            addSubview(playerScoreLabel!)
        }
    }
    
    private var balloonImageView: UIImageView? {
        didSet {
            balloonImageView?.image = UIImage(named: "balloon.png")
            balloonImageView?.backgroundColor = AppColor.darkPurpleColor()
            addSubview(balloonImageView!)
        }
    }
    
    
    private var quoteTextLabel: UILabel? {
        didSet {
            quoteTextLabel?.textColor = .whiteColor()
            quoteTextLabel?.backgroundColor = .clearColor()
            addSubview(quoteTextLabel!)
        }
    }
    
    // MARK: -
    // MARK: Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Always call setupUI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Always call setupUI
        setupUI()
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        whoSaidItLabel?.frame = CGRectMake(BO.x, BO.y, frame.size.width / 2 - BO.x, BS.ButtonHeight)
        playerScoreLabel?.frame = CGRectMake(whoSaidItLabel!.frame.maxX, BO.y, frame.size.width / 2 - BO.x, BS.ButtonHeight)
        balloonImageView?.frame = CGRectMake(BO.x, playerScoreLabel!.frame.maxY, frame.size.width - 2*BO.x, frame.size.width - 2*BO.x)
        quoteTextLabel?.frame = CGRectMake(frame.size.width / 2 - frame.size.width / 3.5, frame.size.width / 3 , frame.size.width / 1.9, frame.size.width / 2.5)
    }
    
    // MARK: -
    // MARK: Public Implementation

    /**
     Initialization && Configuration
     */
    internal func setupUI() {
        
        /**
         *  Configuration
         */
        backgroundColor = AppColor.darkPurpleColor()
        
        /**
         *  Initialization
         */
        
        whoSaidItLabel = UILabel()
        playerScoreLabel = UILabel()
        balloonImageView = UIImageView()
    }
    
    // MARK: -
    // MARK: Private Implementation

    
    private func initQuoteLabel() {
        if quoteTextLabel == nil {
            quoteTextLabel = UILabel()
        }
        
        quoteTextLabel?.text = quoteText
        quoteTextLabel?.numberOfLines = 0
        quoteTextLabel?.lineBreakMode = .ByWordWrapping
        quoteTextLabel?.sizeToFit()
    }
    
    // MARK: -
    // MARK: Actions && Selectors
}

// MARK: - BaseQuoteView Extensions
extension BaseQuoteView {
    
    /**
     Cast BaseQuoteView to BinaryQuoteView
     
     - returns: BinaryQuoteView
     */
    func toBinaryView() -> BinaryQuoteView {
        return self as! BinaryQuoteView
    }
    
    /**
     Cast BaseQuoteView to MultiQuteView
     
     - returns: MultiQuoteView
     */
    func toMultiView() -> MultiQuoteView {
        return self as! MultiQuoteView
    }
}
