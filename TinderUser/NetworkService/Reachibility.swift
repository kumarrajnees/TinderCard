//
//  Reachibility.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Network
import SystemConfiguration

class Reachibility {
    let monitor = NWPathMonitor()
    var isNetworkAvailable = false
    static let sharedInstance: Reachibility = {
        let instance = Reachibility()
        instance.checkNetworkStatus()
        return instance
    }()
 
    func checkNetworkStatus() {
        monitor.pathUpdateHandler = { [weak self] (status) in
            if status.status == .satisfied {
                self?.isNetworkAvailable = true
            } else {
                self?.isNetworkAvailable = true
            }
        }
    }
    
    /// To check wether the Network is available or not
    ///
    /// - Returns: network status
    class func isNetworkConnected_WIFI_WAN() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
            
        }) else {
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
