//
//  Constants.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation

enum APIPath:String {
    case hostName = "randomuser.me" //
    case users = "https://randomuser.me/api/?results=50"
}

enum Color:String {
    case tabUnSelected = "AAAAAA"
    case tabSelected = "CCE85A"
}

public enum Storyboard: String {
    case main = "Main"
    var filename: String {
        return rawValue
    }
}

enum PersonCardAction {
    case none
    case delete
    case markFavourite
    case restoreToOriginalPosition
}

public struct Queue<T> {
    fileprivate var cellqueue:[T] = []
    public var isEmpty: Bool {
        return cellqueue.isEmpty
    }
    public mutating func enqueue(_ element: T) {
        cellqueue.append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        // guard !cellqueue.isEmpty,  else { return nil }
        if (!cellqueue.isEmpty) {
            let element = cellqueue.first
            cellqueue.removeFirst()
            return element
        }else {
            return nil
        }
    }
    public mutating func emptyTray() {
        cellqueue.removeAll()
    }
    public var numberOfItems: Int {
        get { cellqueue.count}
    }
    public func getAllItems () -> [T] {
        cellqueue
    }
    public func peek() -> T? {
        return cellqueue.first
    }
}
