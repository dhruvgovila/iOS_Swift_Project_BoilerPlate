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
    let subject_response = PublishSubject<[String:Any]>()
    
    
    func newtworkRequestAPIcall (serviceName:String ,requestType: Alamofire.HTTPMethod  , parameters: [String:Any]?,headerParams: [String:String],responseType:String){
        
        let strURL = AppConstant.messagesURL + serviceName
        
        
        RxAlamofire
            .requestJSON(requestType, strURL ,parameters:parameters, headers: headerParams)
            .debug()
            .subscribe(onNext: { (r, json) in
                if  var dict  = json as? [String:Any]{
                    var statuscode:Int = r.statusCode
                    if dict["code"] != nil{ statuscode = (dict["code"] as? Int)!}
                    dict[AppConstant.resposeTypeKey] = responseType
                    self.checkResponse(statusCode: statuscode, responseDict: dict ,reposeType: responseType)
                }
            }, onError: {  (error) in
                self.subject_response.onError(error)
                Helper.showAlertViewOnWindow("Error", message: error.localizedDescription)
                
            }).disposed(by: disposebag)
    }
    
    
    func checkResponse(statusCode:Int,responseDict: [String:Any],reposeType:String){
        
        
        switch statusCode {
        case 200...203:
            
            self.subject_response.onNext(responseDict)
            
        case 137:
            
            Helper.showAlertViewOnWindow("Error", message: "You have entered same phone number 3 or more times. Please try a new number")
            self.subject_response.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
            
        case 138:
            
            if reposeType == AppConstant.resposeType.verifyOTP.rawValue{
                Helper.showAlertViewOnWindow("Error", message: "Invalid OTP")
            }else if reposeType == AppConstant.resposeType.requestOtp.rawValue {
                Helper.showAlertViewOnWindow("Error", message: "You have logged-in in the same device more than 6 times.")
            }
            
            self.subject_response.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
            
        case 139:
            
            Helper.showAlertViewOnWindow("Error", message: responseDict["message"] as! String)
            self.subject_response.onError(NSError.init(domain: "", code: statusCode, userInfo: ["message": responseDict["message"] as! String]))
            
        case 140:
            
            Helper.showAlertViewOnWindow("Error", message: "Abuse of device")
            self.subject_response.onError(NSError.init(domain: "", code: statusCode, userInfo: ["message": responseDict["message"] as! String]))
            
        case 204:
            
            Helper.showAlertViewOnWindow("Error", message: responseDict["error"] as! String)
            self.subject_response.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
            
        case 205..<300:
            
            //let resJson = JSON(response.result.value!)
            Helper.showAlertViewOnWindow("Error", message: "")
            self.subject_response.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["message"] as! String]))
            
        case 300..<440:
            
            Helper.showAlertViewOnWindow("Error", message: responseDict["Message"]as! String)
            self.subject_response.onError(NSError(domain: "", code: statusCode, userInfo: ["message":responseDict["error"]as! String]))
            
        case 440:
            
            
            Helper.showAlertViewOnWindow("Error", message: "session Expired")
            self.subject_response.onError(NSError())
            //DDLogDebug("session Expired")
            
        default:
            Helper.showAlertViewOnWindow("Error", message: "Opps just Pray,Reponse will came :P ")
            
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


