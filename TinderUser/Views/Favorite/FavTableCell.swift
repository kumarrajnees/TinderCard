//
//  FavTableCell.swift
//  TinderUser
//
//  Created by Rajneesh Kumar on 7/26/20.
//  Copyright © 2020 Rajneesh Kumar. All rights reserved.
//

import UIKit
import SDWebImage
class FavTableCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var userData:[String:Any]? = [:] {
        didSet {
            userNameLabel.text = userData?["personName"] as? String
            if let imgUrl = userData?["imgUrl"] as? String {
                userImageView.sd_setImage(with: URL.init(string: imgUrl), completed: nil)
            } else {
                userImageView.image =  nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.cornerRadius = userImageView.bounds.width*0.5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
