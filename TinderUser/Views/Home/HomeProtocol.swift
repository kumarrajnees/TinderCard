//
//  HomeProtocol.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import  UIKit

protocol IPHomeViewModelInput: AnyObject {
    func loadDataFromServer()
    func removeLatestCard()
}

protocol IPHomeView: AnyObject {
    func subscripeToShowCard(_ card:PersonCardView, _ position:Int)
    func failureMessages(_ message: String)
}

protocol IPHomeWireFrame: AnyObject {
    func subscripeToShowCard(_ card:PersonCardView, _ position:Int)
    func failureMessages(_ message: String)
}
