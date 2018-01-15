//
//  UploadImageModel.swift
//  DayRunner
//
//  Created by Dhruv Govila on 27/06/17.
//  Copyright © 2017 Dhruv Govila. All rights reserved.
//

import UIKit

struct UploadImage {
    var image = UIImage()
    var path = ""
    
    init(image: UIImage, path: String) {
        self.image = image
        self.path = path
    }
}

class UploadImageModel: NSObject {
    
    private static var manager: UploadImageModel? = nil
    static var shared: UploadImageModel {
        if manager == nil {
            manager = UploadImageModel()
        }
        return manager!
    }
    
    override init() {
        super.init()
    }
    
    var uploadImages: [UploadImage] = []
    private var amazon = AmazonWrapper.sharedInstance()
    private var imageIndex = 0
    
    /// Start Uploading Image
    func start() {
        if imageIndex < uploadImages.count {
            uploadImage(uploadImg: uploadImages[imageIndex])
            imageIndex += 1
        }
        else {
            imageIndex = 0
            print("\n*****************************\nUploading Completed\n*****************************\n")
        }
    }
    
    /// Uplad Images in Background
    ///
    /// - Parameter uploadImg: Upload Image Object
    private func uploadImage(uploadImg: UploadImage) {
        amazon.uploadImageToAmazon(withImage: uploadImg.image, imgPath: uploadImg.path, arg: true, completion: { (success) -> Void in
            if success {
                self.start()
                print("true")
            } else {
                print("false")
            }
        })
        //        amazon.upload(withImage: uploadImg.image,
        //                      imgPath: uploadImg.path,
        //                      completion: {(success, url) in
        //                        print("\n*****************************\nUploaded Image: \(url)\n*****************************\n")
        //                        self.start()
        //        })
    }
}
