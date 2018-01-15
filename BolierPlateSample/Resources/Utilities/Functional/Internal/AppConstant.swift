//
//  Appconstant.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 10/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

class AppConstant {
    
    static let networkAPIURL       = ""
    static let keyChainAccount     = "AppTocken"
    static let resposeTypeKey      = "resposeType"
    static let uploadMultimediaURL = ""
    
    
    
    /*All Api Names */
    struct API {
        static let loginAPI        = "RequestOTP"                //post
        static let verifyEmail     = "verifyEmail"
        static let uploadPhoto     = "upload" 
    }
    
    
    /*All NSuserDefaults keys */
    struct  UserDefaults {
        static let userID           = "userID"
    }
    
    
    
    
    /*Response Types */
    public enum resposeType:String {
        case  callHistoryResponse   = "callHistory"
        case  requestOtp            = "requestOTP"
        case  verifyOTP             = "VerifyOTP"
        case profileResponse        = "Profile"
        case getContactResponse     = "GetContects"
        
    }
    
    
    
    struct LoginAPI {
        
        //Request
        static let  phoneNumber     =  "phoneNumber"
        static let  countryCode     =  "countryCode"
        static let  deviceId        =  "deviceId"
        
        
        //Response
        static let reponse          =  "response"
        
    }
    
    
    
    
    
}
