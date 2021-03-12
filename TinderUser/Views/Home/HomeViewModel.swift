//
//  HomeViewModel.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

final class HomeViewModel: NSObject {
    weak var view:IPHomeView?
    private var personList: [JSON] = []
    var curentDataCount: Int {
        get{ personList.count}
    }
    var cradList = Queue<PersonCardView>()

    private func parseAndLoadView(result:Any) {
        if let personData = JSON.init(result).dictionaryValue["results"]?.arrayValue, personData.count > 0 {
            removeAllPreviousView()
            personList = personData
            addCradView(numberOfItem: 3, position: 0)
        }
    }

    fileprivate func removeAllPreviousView() {
        if let deqcard = cradList.dequeue() {
            deqcard.removeFromSuperview()
            removeAllPreviousView()
        }
    }
    private func removeCardWithAnimation(personCard: PersonCardView) {
        UIView.animate(withDuration: 0.3, animations: {
            if personCard.cardState == .markFavourite {
                personCard.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            } else {
                personCard.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            }
            personCard.alpha = 0
            personCard.layoutIfNeeded()
        }, completion: { success in
            personCard.removeFromSuperview()
            self.personList.removeFirst()
            self.addCradView(numberOfItem: 1, position: 2)
        })
    }
    private func addCradView(numberOfItem:Int, position:Int ) {
        if position > (personList.count - 1) { return}
        for index in 0..<numberOfItem {
            let data = personList[position + index]
            let cardView = PersonCardView()
            cardView.transform = CGAffineTransform(scaleX: 0, y: 0)
            cardView.personData = getTherequiredPersonData(data: data)
            view?.subscripeToShowCard(cardView,position + index)
            cradList.enqueue(cardView)
        }
    }
    
    private func getTherequiredPersonData(data:JSON)-> [String:Any] {
        var result = [String:Any]()
        let title = data["name"]["title"].stringValue
        let firstName = data["name"]["first"].stringValue
        let lastName = data["name"]["last"].stringValue
        result["name"] = "\(title) \(firstName) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        result["imgUrl"] = data["picture"]["medium"].stringValue
        return result
    }
}

extension HomeViewModel: IPHomeViewModelInput {
    //Method to get the data from server
    func loadDataFromServer() {
        User.getDataFromServer { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                self.view?.failureMessages("")
                self.parseAndLoadView(result: value)
            case .failure(let error):
                switch error {
                case .NetworkNotReachable:
                    self.view?.failureMessages("No Network Available, Please check and try again.")
                case .misslaniousMessage(let errorMessage):
                    self.view?.failureMessages(errorMessage)
                default:
                    self.view?.failureMessages(error.localizedDescription)
                }
            }
        }
    }
    
    func removeLatestCard() {
        if let deqcard = cradList.dequeue() {
            if deqcard.cardState == .markFavourite {
                User.saveUserData(personJson: personList.first)
            }
            removeCardWithAnimation(personCard: deqcard)
        }
    }
}
