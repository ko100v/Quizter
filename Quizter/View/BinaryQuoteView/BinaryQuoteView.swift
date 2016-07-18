//
//  BinaryQuoteView.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/17/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit


class BinaryQuoteView: BaseQuoteView {
    
    // MARK: -
    // MARK: Static Declaration
    
    private let AnswerButtonHeight: CGFloat = 50.0
    
    // MARK: -
    // MARK: Public Interface
    
    internal var authorName: String! {
        didSet {
            authorTextLabel?.text = "\(authorName)?"
        }
    }
    
    // MARK: -
    // MARK: Private Interface
    
    private var placeholderImageView: UIImageView? {
        didSet {
            placeholderImageView?.image = UIImage(named: "emoji.png")
            addSubview(placeholderImageView!)
        }
    }
    
    private var authorTextLabel: UILabel? {
        didSet {
            authorTextLabel?.textColor = UIColor.whiteColor()
            authorTextLabel?.textAlignment = .Left
            addSubview(authorTextLabel!)
        }
    }
    
    private var yesButton: UIButton? {
        didSet {
            yesButton?.setTitleColor(.whiteColor(), forState: .Normal)
            yesButton?.setImage(UIImage(named: "yes.png"), forState: .Normal)
            yesButton?.backgroundColor = AppColor.greenColor()
            yesButton?.tag = 1
            yesButton?.addTarget(self, action: #selector(answerButtonPressed(_:)), forControlEvents: .TouchUpInside)
            addSubview(yesButton!)
        }
    }
    
    private var noButton: UIButton? {
        didSet {
            noButton?.setTitleColor(.whiteColor(), forState: .Normal)
            noButton?.setImage(UIImage(named: "no.png"), forState: .Normal)
            noButton?.backgroundColor = AppColor.redColor()
            noButton?.tag = 0
            noButton?.addTarget(self, action: #selector(answerButtonPressed(_:)), forControlEvents: .TouchUpInside)
            addSubview(noButton!)
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
        
        placeholderImageView = UIImageView()
        authorTextLabel = UILabel()
        yesButton = UIButton()
        noButton = UIButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderImageView?.frame = CGRectMake(BO.x, balloonImageViewFrame.maxY + BO.y, BS.ButtonHeight, BS.ButtonHeight)
        authorTextLabel?.frame = CGRectMake(placeholderImageView!.frame.maxX + BO.x, placeholderImageView!.frame.origin.y, frame.size.width - (placeholderImageView!.frame.maxX + BO.x), BS.ButtonHeight)
        yesButton?.frame = CGRectMake(0 , frame.size.height - AnswerButtonHeight, frame.size.width / 2, AnswerButtonHeight)
        noButton?.frame = CGRectMake(yesButton!.frame.maxX, yesButton!.frame.origin.y, frame.size.width / 2, AnswerButtonHeight)
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    
    // MARK: -
    // MARK: Actions && Selectors
    
    func answerButtonPressed(sender: UIButton) {
        /**
         *  Delegation
         */
        delegate?.playerDidAnswer!(sender.tag.boolValue())
    }
}