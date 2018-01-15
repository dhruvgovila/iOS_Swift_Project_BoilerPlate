//
//  APICalls.swift
//  UFly
//
//  Created by Dhruv Govila on 27/10/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class APIErrors: NSObject {
    static let disposeBag = DisposeBag()
    
    /// Status Code in HTTP
    //  This can be used to know what occur has occured by matching the status code in the API Response Header
    enum ErrorCode: Int {
        case success                = 200
        case badRequest             = 400
        case Unauthorized           = 401
        case Required               = 402
        case Forbidden              = 403
        case NotFound               = 404
        case MethodNotAllowed       = 405
        case NotAcceptable          = 406
        case Other                  = 409
        case PreconditionFailed     = 412
        case RequestEntityTooLarge  = 413
        case TooManyAttemt          = 429
        case ExpiredToken           = 477
        case InvalidToken           = 499
        case internalServerError    = 500
        
        init(rawValue: Int)
        {
            switch (rawValue) {
            case 200:
                self = .success
                break
        
            default:
                self = .Other
                break
            }
        }
        
    }
}
