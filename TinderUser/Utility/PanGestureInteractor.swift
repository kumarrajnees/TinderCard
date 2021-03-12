//
//  PanGestureInteractor.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit

class PanGestureInteractor: NSObject, UIGestureRecognizerDelegate {

    // MARK: - init and deinit
    convenience init(view: UIView) {
        self.init(transformView: view, gestureView: view)
    }
    init(transformView: UIView, gestureView: UIView) {
        super.init()
        self.addGestures(v: gestureView)
        self.weakTransformView = transformView
    }
    deinit {
        self.cleanGesture()
    }

    // MARK: - private method
    private weak var weakGestureView: UIView?
    private weak var weakTransformView: UIView?
    private var panGesture: UIPanGestureRecognizer?
    var scubscribeGestureState:((_ state:UIGestureRecognizer.State) -> Void)?
    private func addGestures(v: UIView) {
        v.isUserInteractionEnabled = true
        v.isMultipleTouchEnabled = true
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panProcess(_:)))
        v.isUserInteractionEnabled = true
        panGesture?.delegate = self
        if let gest = panGesture {
            v.addGestureRecognizer(gest)
        }
        self.weakGestureView = v
    }

    private func cleanGesture() {
        if let view = self.weakGestureView {
            if panGesture != nil {
                view.removeGestureRecognizer(panGesture!)
                panGesture = nil
            }
        }
        self.weakGestureView = nil
        self.weakTransformView = nil
    }
    // MARK: - API
    private func setView(view:UIView?) {
        self.setTransformView(view, gestgureView: view)
    }
    private func setTransformView(_ transformView: UIView?, gestgureView:UIView?) {
        self.cleanGesture()
        if let v = gestgureView  {
            self.addGestures(v: v)
        }
        self.weakTransformView = transformView
    }

    open func resetViewPosition() {
        UIView.animate(withDuration: 0.4) {
            self.weakTransformView?.transform = CGAffineTransform.identity
        }
    }

    // MARK: - gesture handle
    // location will jump when finger number change
    private var initPanFingerNumber:Int = 1
    private var isPanFingerNumberChangedInThisSession = false
    private var lastPanPoint:CGPoint = CGPoint(x: 0, y: 0)
    @objc func panProcess(_ recognizer:UIPanGestureRecognizer) {
            //guard let view = recognizer.view else { return }
            scubscribeGestureState?(recognizer.state)
            guard let view = self.weakTransformView else { return }

            // init
            if recognizer.state == .began {
                lastPanPoint = recognizer.location(in: view)
                initPanFingerNumber = recognizer.numberOfTouches
                isPanFingerNumberChangedInThisSession = false
            }

            // judge valid
            if recognizer.numberOfTouches != initPanFingerNumber {
                isPanFingerNumberChangedInThisSession = true
            }
            if isPanFingerNumberChangedInThisSession {
                return
            }

            // perform change
            let point = recognizer.location(in: view)
            view.transform = view.transform.translatedBy(x: point.x - lastPanPoint.x, y: point.y - lastPanPoint.y)
            lastPanPoint = recognizer.location(in: view)
    }

    //MARK:- UIGestureRecognizerDelegate Methods
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }

}

