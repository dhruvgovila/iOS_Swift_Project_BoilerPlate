//
//  ViewModel.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 09/11/2017.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewModel {
    
    var rx_viewModel :Variable<[String:Any]> = Variable([:])
    var rx_Observal : Observable<[String:Any]>!
    
    
    init() {
        setupObsever()
    }
    
    
    func setupObsever(){
        rx_Observal = rx_viewModel.asObservable()
    }
    
    func requestOtpApiCall(params : Model ) {
        
        Helper.showPI()
        
        let paramss = [AppConstant.LoginAPI.phoneNumber:params.phoneNumber,
                       AppConstant.LoginAPI.countryCode:params.countryCode,
                       AppConstant.LoginAPI.deviceId   :params.deviceId] as [String:Any]
        
        
        let apiCall = RxAlmofireClass()
        apiCall.newtworkRequestAPIcall(serviceName: AppConstant.API.loginAPI, requestType: .post, parameters: paramss,headerParams:[:], responseType: AppConstant.resposeType.requestOtp.rawValue)
        apiCall.apiResponse
            .subscribe(onNext: {response in
                
                if(response.status == true){
                    print("success")
                }
                
            }, onError: {error in
    
                Helper.hidePI()
            })
        
        
        
    }
    
    
}
