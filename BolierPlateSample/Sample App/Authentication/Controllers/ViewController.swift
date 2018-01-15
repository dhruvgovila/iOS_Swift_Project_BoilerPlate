//
//  ViewController.swift
//  BolierPlateSample
//
//  Created by Dhruv Govila on 09/11/2017.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import CocoaLumberjack
import Locksmith
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    let viewModelClass =  ViewModel()
    let number  = "9876543210"
    let countryCode = "+91"
    let deviceID = UIDevice.current.identifierForVendor?.uuidString
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Use keychain
        guard let keyDict = Locksmith.loadDataForUserAccount(userAccount: AppConstant.keyChainAccount) else {return}
        DDLogDebug("keychain Store \(keyDict)")
        
        
        
        // Do any additional setup after loading the view.
        let params =   Model.init(phoneNumber:number , countryCode: countryCode, deviceId: deviceID!)
        viewModelClass.requestOtpApiCall(params: params)
        
        viewModelClass.rx_Observal.subscribe(onNext: { (response) in
            print("***********************************hello im changed here ***********************************")
           
        }).disposed(by: disposeBag)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}
