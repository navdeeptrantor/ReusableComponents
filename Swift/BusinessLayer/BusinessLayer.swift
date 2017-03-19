//
//  BusinessLayer.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class BusinessLayer: NSObject
{
    
    class func signUpForOtp(with params:[String:Any], completionHandler: @escaping (JSON?, String?) -> ()) {
        showProgressView()
        CommManager.postApi(params, UrlStr: kSignUpUrl) { (result, error) in
            printLog("error:\(error)")
            completionHandler(result,error)
            hideProgressView()
        }
    }
    
}
