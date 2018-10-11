//
//  MyGroupCell.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import Kingfisher

class MyGroupCell: UITableViewCell {

    @IBOutlet weak var avatarGroupImage: UIImageView!
        {
        didSet{
            self.avatarGroupImage.circle()
        }
    }
    @IBOutlet weak var nameGropLabel: UILabel!
    
    override func prepareForReuse() {
        avatarGroupImage.kf.cancelDownloadTask()
        avatarGroupImage.image = nil
    }
    
    func setup (with myGroup: Group){
        nameGropLabel.text = myGroup.name
        let avatarUrl = URL(string: myGroup.avatar)
        avatarGroupImage.kf.setImage(with: avatarUrl)
    }
}
