//
//  Model.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 09/11/2017.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

class Model: NSObject {
    
    
    var  phoneNumber: String
    var  countryCode : String
    var  deviceId : String
    
    //authorization
    
    init(phoneNumber: String,countryCode: String,deviceId: String) {
        self.phoneNumber = phoneNumber
        self.countryCode = countryCode
        self.deviceId = deviceId
        
    }
    
    
    
    
    

}
