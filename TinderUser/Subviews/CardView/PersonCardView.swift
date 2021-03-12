//
//  PersonCardView.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class PersonCardView: UIView, NibInstantiatable, EmbeddedNibInstantiatable {
    typealias Embedded = PersonCardView
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userProfileBaseView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileTab: TabView!
    @IBOutlet weak var calendar: TabView!
    @IBOutlet weak var phoneTab: TabView!
    @IBOutlet weak var locationTab: TabView!
    @IBOutlet weak var securityTab: TabView!
    @IBOutlet weak var personNameLabel: UILabel!

    var previousSelecetdTab: TabView?
    var parentView:UIView?
    var pangesture: PanGestureInteractor?
    var cardState: PersonCardAction = .none
    var cardPositionChanged: ((_ action: PersonCardAction, _ cardView: PersonCardView) -> Void)?
    var personData:[String:Any] = [:] {
        didSet {
            if let name = personData["name"] as? String {
                personNameLabel.text = name
            }
            if let imgURL = personData["imgUrl"] as? String {
                userProfileImageView.sd_setImage(with: URL.init(string: imgURL), completed: nil)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        congigureUI()
    }
    // MARK: Class LifeCycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEmbededView(self)
        congigureUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureEmbededView(self)
    }
    
   fileprivate func congigureUI() {
        let containerView = self.subviews[0]
        updateConstrainsAdjustFullScreen(containerView: containerView)
        userProfileBaseView.drawBorder(.darkGray, 1)
        previousSelecetdTab = profileTab
        pangesture =  PanGestureInteractor.init(view: self)
        subscribeTabsForSelectionEvent()
        self.layoutIfNeeded()
        self.drawBorder(.systemGray2, 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userProfileBaseView.cornerRadius = userProfileBaseView.bounds.width*0.5
        userProfileImageView.cornerRadius = userProfileImageView.bounds.width*0.5
    }
    
    private func subscribeTabsForSelectionEvent() {
        profileTab.subscribeOnSelection = { [unowned self] (selected) in
            self.resetPreviousSelectedTabs(newTab: self.profileTab)
        }
        calendar.subscribeOnSelection = { [unowned self] (selected) in
            self.resetPreviousSelectedTabs(newTab: self.calendar)
        }
        phoneTab.subscribeOnSelection = {[unowned self] (selected) in
            self.resetPreviousSelectedTabs(newTab: self.phoneTab)
        }
        locationTab.subscribeOnSelection = { [unowned self](selected) in
            self.resetPreviousSelectedTabs(newTab: self.locationTab)
        }
        securityTab.subscribeOnSelection = {[unowned self] (selected) in
            self.resetPreviousSelectedTabs(newTab: self.securityTab)
        }
        
        pangesture?.scubscribeGestureState = { [unowned self] (currentState) in
                if currentState == .ended || currentState == .failed || currentState == .cancelled {
                    self.checkCardCurrentPosition()
                }
        }
    }
    private func checkCardCurrentPosition() {
        if let cardSuperView = self.superview {
            let centPoint = CGPoint(x: UIScreen.main.bounds.width*0.5, y: cardSuperView.bounds.height*0.5)
            var position = PersonCardAction.restoreToOriginalPosition
            let cardXPosition =  self.frame.origin.x
            let cardEndPosition = self.frame.origin.x + self.frame.width
            if cardXPosition >= centPoint.x {
                position = .markFavourite
            } else if cardEndPosition <= centPoint.x {
                position = .delete
            } else {
                position = .restoreToOriginalPosition
            }
            cardState = position
            cardPositionChanged?(position,self)
        }
    }
    private func resetPreviousSelectedTabs(newTab:TabView) {
        previousSelecetdTab?.isSelected = false
        previousSelecetdTab = newTab
    }
}
