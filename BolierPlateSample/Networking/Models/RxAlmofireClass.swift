//
//  RxAlmofiree.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 10/11/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire
import CocoaLumberjack

class RxAlmofireClass {
    
    let disposebag = DisposeBag()
    let apiResponse = PublishSubject<ApiResponse>()
    
    
    func newtworkRequestAPIcall (serviceName:String ,requestType: Alamofire.HTTPMethod  , parameters: [String:Any]?,headerParams: [String:String],responseType:String){
        
        let strURL = AppConstant.networkAPIURL + serviceName
        
        
        RxAlamofire
            .requestJSON(requestType, strURL ,parameters:parameters, headers: headerParams)
            .debug()
            .subscribe(onNext: { (header, jsonBody) in
                if  var dict  = jsonBody as? [String:Any]{
                    var statuscode:Int = header.statusCode
                    if dict["code"] != nil{ statuscode = (dict["code"] as? Int)!}
                    dict[AppConstant.resposeTypeKey] = responseType
                    self.checkResponse(statusCode: statuscode, responseDict: dict ,reposeType: responseType)
                }
            }, onError: {  (error) in
                self.apiResponse.onError(error)
                Helper.showAlertViewOnWindow("Error", message: error.localizedDescription)
                
            }).disposed(by: disposebag)
    }
    
    
    func checkResponse(statusCode:Int,responseDict: [String:Any],reposeType:String){
        
        
        let apiResponseStatusCode: APIErrors.ErrorCode = APIErrors.ErrorCode(rawValue: statusCode)
        switch apiResponseStatusCode {
        case .success:
            self.apiResponse.onNext(ApiResponse.init(status: true, response: responseDict))
            
        default:
            print("Some Error Occured")
            self.apiResponse.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
        }
    }
    
    
    
    func uploadImageToserver(image:UIImage)-> Observable<String>{

        return Observable<String>.create({ observal in
            let strURL = AppConstant.uploadMultimediaURL + AppConstant.API.uploadPhoto
            let imageData = UIImageJPEGRepresentation(image, 0.4)
            let name = Date().timeIntervalSince1970 * 1000
            
            Alamofire.upload(multipartFormData:{ multipartFormData in
                multipartFormData.append(imageData!, withName: "photo", fileName: "\(name).jpeg", mimeType: "image/*|video/*|audio/*")
            },
                             usingThreshold:UInt64.init(),
                             to:strURL,
                             method:.post,
                             headers:nil,
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    
                                    upload.responseJSON { [weak self] response in
                                        
                                        guard self != nil else {
                                            return
                                        }
                                        guard response.result.error == nil else {
                                            return
                                        }
                                        if let value: Any = response.result.value {
                                            observal.onNext(value as! String) //value["path"]
                                        }
                                    }
                                    
                                case .failure(let encodingError):
                                    DDLogDebug("an error :\(encodingError)")
                                }
                })
            
            return Disposables.create();
        })
    }
    
}


