//
//  Dimensions.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

/**
 *  typealias
 */

typealias BO = Dimensions.Offset
typealias BS = Dimensions.Size

/**
 *  **** Dimensions ****
 */
public struct Dimensions {
    
    public struct Offset {
        static let x: CGFloat = 8
        static let y: CGFloat = BO.x
    }
    
    public struct Size {
        static let StatusBarHeight: CGFloat = 20
        static let NavigationBarHeight: CGFloat = 44
        static let SNHeight: CGFloat = BS.StatusBarHeight + BS.NavigationBarHeight
        static let ButtonHeight: CGFloat = 44
    }
    
}