//
//  ViewControllerProtocol.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
/// This protocol provide default `identifire` for your Class
/// The default identifire is your class name. You can customize it by providing `identifire` property.
protocol Identifiable: AnyObject {
    static var identifire: String { get }
}
// Default value of `identifire`: Your class name
extension Identifiable where Self: NSObject {
    static var identifire: String { return className }
}

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable {
        public static var storyboardIdentifier: String {
            return String(describing: self)
        }
}

extension UIViewController {
    func showAler(message:String) {
        let alert = UIAlertController.init(title: "Error!", message: message, preferredStyle: .alert)
        let action =  UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
