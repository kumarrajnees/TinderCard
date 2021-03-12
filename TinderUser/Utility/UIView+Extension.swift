//
//  UIView+Extension.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func dropShadow(_ shadowColor: UIColor = UIColor.black,shadowRadius: CGFloat = 5,_ shadowOffset: CGSize = CGSize.zero ) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    func updateCornerradius(_ radius:CGFloat = 5.0) {
        self.layer.cornerRadius = radius
    }
    func drawBorder(_ colour:UIColor = UIColor.black,_ lineWidth:CGFloat = 1.0) {
        self.layer.borderColor = colour.cgColor
        self.layer.borderWidth = lineWidth
    }
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0.0, y: 0.0)
        layer.cornerRadius = CGFloat(frame.width / 20)
        let color0 = UIColor(red:31.0/255, green:212.0/255, blue:227.0/255, alpha:1.0).cgColor
        let color1 = UIColor(red:170.0/255, green:182.0/255, blue: 185.0/255, alpha:1.0).cgColor
        layer.colors = [color0,color1]
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func getHEXStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.2,
                   shadowRadius: CGFloat = 7.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension UIView {
    func updateConstrainsAdjustFullScreen(containerView:UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

    func addConstrainsToCardView(mappingView:UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: mappingView, attribute: .width, multiplier: 1, constant: -20).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: mappingView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: mappingView, attribute: .top, multiplier: 1, constant: 10).isActive = true
    }
}
