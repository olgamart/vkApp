//
//  MyFriendsCell.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import Kingfisher

class MyFriendsCell: UITableViewCell {
    //@IBOutlet weak var friendNameLabel:UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
        {
        didSet{
            self.avatarImage.circle()
        }
    }

    @IBOutlet weak var friendNameLabel: UILabel!
    
    override func prepareForReuse() {
        avatarImage.kf.cancelDownloadTask()
        avatarImage.image = nil
    }
    
    func setup (with friend: Friend){
        friendNameLabel.text = friend.first_name + " " + friend.last_name
        let avatarUrl = URL(string: friend.avatar)
        avatarImage.kf.setImage(with: avatarUrl)
    }

}
