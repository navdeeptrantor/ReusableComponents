//
//  CommManager.swift
//  NODAT
//
//  Created by NavdeepSingh on 28/02/17.
//  Copyright © 2017 Trantor Inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommManager: NSObject {
    
    //Mark :-  Alamofire Sessions
    class func postApi(_ parametersStr:[String : Any], UrlStr: String, completionHandler: @escaping (JSON?, String?) -> ()) ->Void
    {
        do {
            
            // TODO: handle no network
            
            
            let jsonData =  try JSONSerialization.data(withJSONObject: parametersStr, options: .prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as! String
            printLog("Parameters JSON:\(jsonString)")
            
            
            let parameters: Parameters = parametersStr
            //print(parametersStr)
            
            /*let headers: HTTPHeaders = [
             "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
             "Accept": "application/json"
             ]*/
            
            
            Alamofire.request(UrlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(let value):
                    let json = JSON(value)
                    printLog("Response JSON: \(json)")
                    if json != JSON.null {
                        completionHandler(json as JSON?, nil)
                    }
                    else {
                        completionHandler(JSON.null, "error occured")
                    }
                    
                case .failure(let error):
                    printLog("Error : \(error.localizedDescription)")
                    completionHandler(JSON.null, error.localizedDescription)
                    
                }
            }
        }
        catch
        {
            printLog("error occured while making api call")
        }
    }
    
}
