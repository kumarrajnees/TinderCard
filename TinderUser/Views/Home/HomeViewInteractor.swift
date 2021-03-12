//
//  HomeViewInteractor.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit

struct HomeViewInteractor {
    
    func showViewController(presenter:UIViewController, classIdenteifer:String) {
        if let storyboard = presenter.storyboard  {
            let vc = storyboard.instantiateViewController(withIdentifier: classIdenteifer)
            presenter.present(vc, animated: true, completion: nil)
        }
    }
}
