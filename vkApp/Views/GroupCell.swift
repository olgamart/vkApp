//
//  GroupCell.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import Kingfisher

class GroupCell: UITableViewCell {

    @IBOutlet weak var avatarGroupImage: UIImageView!
        {
        didSet{
            self.avatarGroupImage.circle()
        }
    }
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var numbersGroupLabel: UILabel!
    
    override func prepareForReuse() {
        avatarGroupImage.kf.cancelDownloadTask()
        avatarGroupImage.image = nil
    }
    
    func setup (with group: Group) {
        nameGroupLabel.text = group.name
        numbersGroupLabel.text = String(group.numbers)
        let avatarUrl = URL(string: group.avatar)
        avatarGroupImage.kf.setImage(with: avatarUrl)        
    }
}
