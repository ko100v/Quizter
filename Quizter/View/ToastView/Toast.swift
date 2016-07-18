//
//  ToastView.swift
//  Quizter
//
//  Created by Dimitar Kostov on 7/17/16.
//  Copyright © 2016 Dimitar Kostov. All rights reserved.
//

import UIKit

class Toast {
    
    /**
     Show toast view with value of selected answer
     
     - parameter value: Bool
     */
    class func show(value: Bool) {
        
        /// Get screen center
        let center = (UIApplication.sharedApplication().keyWindow?.center)!
        
        let toastView = UIView()
        toastView.frame = CGRectMake(center.x - 100, center.y - 22 , 200, 44)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
    
    
        
        let imgView = UIImageView(frame: CGRectMake(BO.x, 44 / 2 - 33 / 2, 33, 33))
        imgView.image = UIImage(named: value ? "yes.png" : "no.png")
        
        /// Create label
        let toast = UILabel()
        toast.frame = CGRectMake(imgView.frame.maxX + BO.x, 0, toastView.frame.size.width - (imgView.frame.maxX + 2*BO.x), 44)
        toast.textColor = .whiteColor()
        
        /**
         *  Set specific value
         */
        if value {
            toastView.backgroundColor = AppColor.greenColor()
            toast.text = "True"
        } else {
            toastView.backgroundColor = AppColor.redColor()
            toast.text = "False"
        }
        
        toastView.addSubview(imgView)
        toastView.addSubview(toast)
        
        /**
         *  Add as subview
         */
        UIApplication.sharedApplication().keyWindow?.addSubview(toastView)
        
        /// Create new waiting queue
        let waitingQueue = dispatch_queue_create("waitingQueue", nil)
        /**
         *  Execute background queue
         */
        dispatch_async(waitingQueue) {
            /**
             *  Wait half of second
             */
            NSThread.sleepForTimeInterval(0.5)
            /**
             *  Get main queue
             */
            dispatch_async(dispatch_get_main_queue(), {
                /**
                 *  Remove toast with animation
                 */
                UIView.animateWithDuration(0.5, animations: {
                    toastView.alpha = 0
                    }, completion: { (_) in
                        toastView.removeFromSuperview()
                })
            })
        }
    }
}
