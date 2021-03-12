//
//  ViewController.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/24/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blackBoxView: UIView!
    @IBOutlet weak var cardBaseView: UIView!
    var viewModel:IPHomeViewModelInput?
    var interactor:HomeViewInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.loadDataFromServer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func refeshBtnPressed(_ sender: UIButton) {
        viewModel?.loadDataFromServer()
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        interactor.showViewController(presenter: self, classIdenteifer: FavListViewController.className)
    }
    
    //MARK:- Private Methods
    
    private func addCardView(cardView:PersonCardView,position:Int) {
        let numberOfSubView = view.subviews.count
        if numberOfSubView == 2 {
            view.addSubview(cardView)
        } else {
            view.insertSubview(cardView, at: 2)
        }
        adjsutNextCardView()
        cardView.addConstrainsToCardView(mappingView: blackBoxView)
        cardView.layoutIfNeeded()
        cardView.cardPositionChanged = { [unowned self] poistion, personCard in
            if poistion == .restoreToOriginalPosition {
                self.repositionViewWithANimation(personCard: personCard)
            } else {
                self.viewModel?.removeLatestCard()
            }
        }
    }
    
    private func repositionViewWithANimation(personCard: PersonCardView) {
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            personCard.transform = .identity
            personCard.addConstrainsToCardView(mappingView: self.blackBoxView)
            personCard.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func adjsutNextCardView() {
        let list =  view.subviews
        for (index,card) in list.reversed().enumerated() where card.className == PersonCardView.className {
            UIView.animate(withDuration: 0.3, animations: {
                self.createStackView(cardView: card as! PersonCardView, position: index)
            }, completion: nil)
        }
    }
    
    private func createStackView(cardView:PersonCardView,position:Int) {
        if position == 0 {
            cardView.transform = .identity
        } else {
            let scalingfactor = CGFloat(1.0 - Double(position)*0.01)
            let tra  = CGAffineTransform(scaleX: scalingfactor, y: scalingfactor).translatedBy(x: 0, y: CGFloat(position*10))
            cardView.transform = tra
        }
    }
}


extension ViewController: IPHomeView {
    func subscripeToShowCard(_ card: PersonCardView, _ position: Int) {
        self.addCardView(cardView: card, position: position)
    }
    
    func failureMessages(_ message: String) {
        if message.count > 0 {
            self.showAler(message: message)
        }
    }
}
