//
//  APIServices.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Alamofire
typealias responsHandler = (Result<Any,ServiceError>) ->Void
enum ServiceError: Error {
    case ServerResponseFailed
    case NetworkNotReachable
    case misslaniousMessage(String)
}

class APIService {
    
    class func getUserData(completion : @escaping (responsHandler)) {
        if !Reachibility.isNetworkConnected_WIFI_WAN()   {
            completion(.failure(.NetworkNotReachable))
            return
        }
        let eventURL = APIPath.users.rawValue
        APIManager.request(urlString: eventURL, requestMethod: .get, headers: [:], params: nil, success: { (response) in
            completion(.success(response))
        }) { (error) in
            completion(.failure(.misslaniousMessage(error.description)))
        }
    }
    
}
