//
//  HomeWireFrame.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit

class HomeWireFrame {
    
   @discardableResult static func showHomeView(navCtrl: UINavigationController?) -> UIViewController? {
        let storyBoard = UIStoryboard.init(storyboard: .main)
        let viewmodel = HomeViewModel()
        let homeView: ViewController = storyBoard.instantiateViewController(identifier: ViewController.className)
        homeView.interactor = HomeViewInteractor()
        homeView.viewModel = viewmodel
        viewmodel.view = homeView
        return homeView
    }
}
