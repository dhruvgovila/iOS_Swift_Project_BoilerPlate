//
//  File.swift
//  AmazonWrapper
//
//  Created by Dhruv Govila on 27/03/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit
import AWSS3

let AmazonAccessKey  = ""
let AmazonSecretKey  = ""
let Bucket  = ""

protocol AmazonWrapperDelegate {
    /**
     *  Facebook login is success
     *
     *  @param userInfo Userdict
     */
    
    func didImageUploadedSuccessfully(withDetails imageURL: String)
    /**
     *  Login failed with error
     *
     *  @param error error
     */
    
    func didImageFailtoUpload(_ error: Error?)
    
    
}

class AmazonWrapper: NSObject {
    
    static var share:AmazonWrapper?
    var delegate: AmazonWrapperDelegate?
    
    class func sharedInstance() -> AmazonWrapper {
        
        if (share == nil) {
            
            share = AmazonWrapper.self()
            
        }
        return share!
    }
    
    override init() {
        super.init()
        
    }
    
    func setConfigurationWithRegion(_ regionType: AWSRegionType, accessKey: String, secretKey: String) {
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region: regionType, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    
    func uploadImageToAmazon(withImage image: UIImage, imgPath:String,arg: Bool, completion: @escaping (Bool) -> ()) {
        print("First line of code executed")
        // do stuff here to determine what you want to send back.
        // we are just sending the Boolean value that was sent in back
        //        completion(arg)
        //    }
        //
        //
        //    func uploadImageToAmazon(withImage image: UIImage, imgPath:String) {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmssa"
        
        var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [AnyObject]
        let documentsDirectory: String = paths[0] as! String
        
        let photoURLPath = NSURL(fileURLWithPath: documentsDirectory)
        let getImagePath  = photoURLPath.appendingPathComponent("\(formatter.string(from:Date())).png")
        
        
        if !FileManager.default.fileExists(atPath: getImagePath!.path) {
            do {
                try UIImageJPEGRepresentation(image, 1.0)?.write(to: getImagePath!)
                print("file saved")
            }catch {
                print("error saving file")
            }
        }
        else {
            print("file already exists")
        }
        
        
        AWSS3TransferUtility.default().uploadFile(getImagePath!,
                                                  bucket: Bucket,
                                                  key: imgPath,
                                                  contentType: "image/png", expression:nil) { (task, error) in
                                                    
                                                    if (error != nil) {
                                                        
                                                        if (self.delegate != nil)  {
                                                            self.delegate?.didImageFailtoUpload(error)
                                                        }
                                                        
                                                    }
                                                    else {
                                                        let uploadedImageURL = String(format:"https://s3-us-west-2.amazonaws.com/%@/%@",Bucket,imgPath)
                                                        completion(arg)
                                                        if (self.delegate != nil)  {
                                                            self.delegate?.didImageUploadedSuccessfully(withDetails: uploadedImageURL)
                                                        }
                                                        
                                                    }
                                                    
        }
        
        
    }
    
    
}
