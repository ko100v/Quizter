//
//  ViewController.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    // MARK: -
    // MARK: Static Declaration
    
    // MARK: -
    // MARK: Public Interface
    
    // MARK: -
    // MARK: Private Interface
    
    // MARK: -
    // MARK: Constructors
    
    // MARK: -
    // MARK: ViewController LifeCycle
    
    override func loadView() {
        super.loadView()
        // Configure view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Always call setupUI on viewDidLoad
        setupUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: -
    // MARK: Override Base
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        /**
         *  Layout && Geometry
         */
        layoutUI()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: -
    // MARK: Public Implementation
    
    
    /**
     Initialization && Configuration
     */
    internal func setupUI() {
        
        /**
         Initialization
         */
        
        /**
         Configuration
         */
        view.backgroundColor = AppColor.darkPurpleColor()
    }
    
    
    /**
     Update UI related elements
     */
    internal func updateUI() {
        
    }
    
    /**
     Layout UI related elements
     */
    internal func layoutUI() {
        
    }
    
    /**
     Clear UI related elements
     */
    internal func clearUI() {
        
    }
    
    // MARK: -
    // MARK: Private Implementation
    
    
    // MARK: -
    // MARK: Actions && Selectors
}