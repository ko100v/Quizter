//
//  QuestionTableViewCell.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/14/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    // MARK: -
    // MARK: Constructors
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func drawRect(rect: CGRect) {
        
        self.textLabel?.textColor = .whiteColor()
        self.textLabel?.backgroundColor = .magentaColor()
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .ByWordWrapping
        self.textLabel?.textAlignment = .Center
        self.textLabel?.layer.cornerRadius = 10
        
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    // MARK: -
    // MARK: Private Implementation
    
    // MARK: -
    // MARK: Actions && Selectors
    
}
