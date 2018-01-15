//
//  ApiResponse.swift
//  Karru
//
//  Created by Dhruv Govila on 22/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

//This class can be used as to make the model of the APIResponse.
//The object can be created of it and then be passed
class ApiResponse: NSObject {

    var status = Bool()
    var data = [String:Any]()
    
    init(status:Bool,response:[String:Any]) {
        self.status = status
        self.data = response
    }
}
