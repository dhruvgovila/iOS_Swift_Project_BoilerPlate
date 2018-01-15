//
//  Helper.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 10/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    
    class func isValidEmail(emailText: String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailText)
    }

    
    class func showAlertViewOnWindow(_ title: String , message: String) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    // Show with Default Message
    class func showPI() {
        
        let activityData = ActivityData(size: CGSize(width: 30,height: 30),
                                        message: "Loading...",
                                        type: NVActivityIndicatorType(rawValue: 29),
                                        color: UIColor.white,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    // Show with Your Message
    class func showPI(_message:  String) {
        
        let activityData = ActivityData(size: CGSize(width: 30,height: 30),
                                        message: _message,
                                        type: NVActivityIndicatorType(rawValue: 29),
                                        color: UIColor.white,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    // Hide
    class func hidePI() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    
}
