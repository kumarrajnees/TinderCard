//
//  APIManager.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    
    var reqestList:NSMutableSet = NSMutableSet()
    var manager:Session?
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        // setup code
        return instance
    }()
    
    
    class func request(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, success:@escaping (Any) -> Void, failure:@escaping (HNError) -> Void){

        if APIManager.sharedInstance.manager == nil {
            APIManager.sharedInstance.createSessionManager()
        }
        
        APIManager.sharedInstance.manager?.request(urlString, method : requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                let dnError = HNError()
                dnError.statusCode = errorStatusCode
                if dnError.statusCode == 0 {
                    debugPrint(response)
                }
                dnError.description = error.localizedDescription
                failure(dnError)
            }
        }
    }
    
    
    
    func createSessionManager() {
            
            
            let configuration: URLSessionConfiguration = {
                let configuration = URLSessionConfiguration.default
                configuration.headers = .default
                configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                configuration.urlCache = nil
                return configuration
            }()

            configuration.timeoutIntervalForRequest = 60
            manager = {
                let manager = ServerTrustManager(evaluators: [APIPath.hostName.rawValue: DisabledTrustEvaluator()])
                let configuration = URLSessionConfiguration.af.default
                return Session(configuration: configuration, serverTrustManager: manager)
            }()
        }
}

class HNError {
    var statusCode : Int = 0
    var description : String = ""
}
