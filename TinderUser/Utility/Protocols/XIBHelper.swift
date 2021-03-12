//
//  XIBHelper.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
/// This protocol defines the required properies for `Nib`.
/// This protocol has default values for each property. You can costomize it by implementing it.
/// # Properties:
///     nibName: it provides the name of the `Nib` file
///     nibBundle: bundle for the Nib file.
///     nibOptions: options for Nib instance.
///     instantiateIndex: The index of the view in the view hierarchy.
public protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOptions: [UINib.OptionsKey: Any]? { get }
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var nibName: String { return className }
    static var nibBundle: Bundle { return Bundle(for: self) }
    static var nibOptions: [UINib.OptionsKey: Any]? { return nil }
    static var instantiateIndex: Int { return 0 }
}

public extension NibInstantiatable where Self: UIView {
    /// instantiates the in-memory contents of the receiver’s nib file
    //and returns the ÙIView` instance for the given `instantiateIndex`.
    /// It also add the owner of the Nib.
    ///
    /// - Parameters:
    ///     - owner: Owner for the Nib.
    static func instantiate(_ owner: Any) -> UIView {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return (nib.instantiate(withOwner: owner, options: nibOptions)[instantiateIndex] as? UIView)!
    }
}

// MARK: - For Embedded View
public protocol EmbeddedNibInstantiatable {
    associatedtype Embedded: NibInstantiatable
}

public extension EmbeddedNibInstantiatable where Self: UIView, Embedded: UIView {
    var embedded: Embedded { return (subviews[0] as? Embedded)! }
    /// Call this method to configure your Embedded View.
    //It adds embedded view to superview on top in the view hierarchy.
    /// Fill superview with embedded view and set given owner to nib.
    ///
    /// - Parameters:
    ///     - owner: Owner for the Nib.
    func configureEmbededView(_ owner: Any) {
        let view = Embedded.instantiate(owner)
        insertSubview(view, at: 0)
    }
}
