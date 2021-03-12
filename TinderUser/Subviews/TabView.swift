//
//  TabView.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/25/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import UIKit

class TabView: UIView,NibInstantiatable, EmbeddedNibInstantiatable {
    typealias Embedded = TabView
    @IBOutlet weak var selectionStateBarView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabIconImageView: UIImageView!
    var subscribeOnSelection:((_ newState: Bool)-> Void)?
   @IBInspectable var isSelected: Bool = false {
        didSet {
            if isSelected {
                let selectionCOlour = getHEXStringToUIColor(hex: Color.tabSelected.rawValue)
                selectionStateBarView.backgroundColor = selectionCOlour
                tabIconImageView.tintColor = selectionCOlour
            } else {
                let unSelectionCOlour = getHEXStringToUIColor(hex: Color.tabUnSelected.rawValue)
                selectionStateBarView.backgroundColor = .clear
                tabIconImageView.tintColor = unSelectionCOlour
            }
        }
    }
    
   @IBInspectable var tabIcon: UIImage? =  nil {
        didSet {
            tabIconImageView.image = tabIcon
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate func configureUI() {
       let containerView = self.subviews[0]
        updateConstrainsAdjustFullScreen(containerView: containerView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    // MARK: Class LifeCycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureEmbededView(self)
        configureUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureEmbededView(self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isSelected {
            self.isSelected = !self.isSelected
            subscribeOnSelection?(isSelected)
        }
    }

}
