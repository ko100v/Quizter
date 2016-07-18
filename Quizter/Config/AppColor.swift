//
//  AppColor.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/13/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit


class AppColor: NSObject {
    
    /**
     Application dark purple color
     
     - returns: UIColor
     */
    internal class func darkPurpleColor() -> UIColor {
        return UIColor(red: 0.220, green: 0.000, blue: 0.235, alpha: 1)
    }
    
    /**
     Application green color
     
     - returns: UIColor
     */
    internal class func redColor() -> UIColor {
        return UIColor(red: 0.988, green: 0.314, blue: 0.259, alpha: 1.00)
    }
    
    /**
     Application red color
     
     - returns: UIColor
     */
    internal class func greenColor() -> UIColor {
        return UIColor(red: 0.180, green: 0.800, blue: 0.443, alpha: 1.00)
    }
}
