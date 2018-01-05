//
//  Appconstant.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 10/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

class AppConstant {
    
    static let messagesURL         = "http://104.236.32.23:5015/"   //"http://159.203.135.99:1883/"
    static let keyChainAccount     = "HolaAppTocken"
    static let resposeTypeKey      = "resposeType"
    static let uploadMultimediaURL = "http://104.236.32.23:8009/"
    static let authorization       = "KMajNKHPqGt6kXwUbFN3dU46PjThSNTtrEnPZUefdasdfghsaderf1234567890ghfghsdfghjfghjkswdefrtgyhdfghj"
    
    
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
