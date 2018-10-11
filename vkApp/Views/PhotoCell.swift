//
//  PhotoCell.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
   
    @IBOutlet weak var photoFriendImage: UIImageView!
    
    override func prepareForReuse() {
        photoFriendImage.kf.cancelDownloadTask()
        photoFriendImage.image = nil
    }
    
    func setup (with photo: Photo){
        let url = URL(string: photo.photoUrl)
        photoFriendImage.kf.setImage(with: url)
    }
    
}

