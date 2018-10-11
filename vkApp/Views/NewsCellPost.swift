//
//  NewsCellPost.swift
//  vkApp
//
//  Created by Olga Martyanova on 16/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import Kingfisher
import PinLayout

class NewsCellPost: UITableViewCell {
    let avatarImageSize: CGFloat = 36
    let newsSizeWidth: CGFloat = 300
    let newsSizeHeight: CGFloat = 175
    let scalableIndent: CGFloat = 5
    let iconWidth: CGFloat = 24
    let countLabelSize: CGFloat = 35
    let countLabelSizeLarge: CGFloat = 45
    let indent: CGFloat = 8    

    @IBOutlet weak var viewsIcon: UIImageView!
        {
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var commentsIcon: UIImageView!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var repostsIcon: UIImageView!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var likesIcon: UIImageView!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var viewsLabel: UILabel!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var commentsLabel: UILabel!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var repostsLabel: UILabel!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var likesLabel: UILabel!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var postTextLabel: UITextView!
        {
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var authorLabel: UILabel!{
        didSet{
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var avatarNewsImage: UIImageView!
        {
        didSet{
            self.avatarNewsImage.circle()
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func prepareForReuse() {
        avatarNewsImage.kf.cancelDownloadTask()
        avatarNewsImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postCellLayout()
    }
    
    func setup (with news: News){
        authorLabel.text = news.author
        let avatarUrl = URL(string: news.avatar)
        avatarNewsImage.kf.setImage(with: avatarUrl)
        postTextLabel.text = news.text
        likesLabel.text = String(news.likes)
        repostsLabel.text = String(news.reposts)
        commentsLabel.text = String(news.comments)
        viewsLabel.text = String(news.views)
        postCellLayout()
    }
    
    func postCellLayout(){
        
        avatarNewsImage.pin.topLeft(2 * scalableIndent).size(avatarImageSize)
        authorLabel.pin.left(to: avatarNewsImage.edge.right).vCenter(to: avatarNewsImage.edge.vCenter)
            .margin(3 * scalableIndent).width(7 * countLabelSize)
        postTextLabel.pin.top(to: avatarNewsImage.edge.bottom).margin(indent).hCenter()
            .width(newsSizeWidth).height(newsSizeHeight)
        likesIcon.pin.bottomLeft(2 * scalableIndent).size(iconWidth)
        likesLabel.pin.left(to: likesIcon.edge.right).vCenter(to: likesIcon.edge.vCenter)
            .margin(2 * scalableIndent).width(countLabelSize)
        repostsIcon.pin.left(to: likesLabel.edge.right).vCenter(to: likesIcon.edge.vCenter)
            .margin(indent).size(iconWidth)
        repostsLabel.pin.left(to: repostsIcon.edge.right).vCenter(to: likesIcon.edge.vCenter)
            .margin(indent).width(countLabelSize)
        commentsIcon.pin.left(to: repostsLabel.edge.right).vCenter(to: likesIcon.edge.vCenter)
            .margin(indent).size(iconWidth)
        commentsLabel.pin.left(to: commentsIcon.edge.right).vCenter(to: likesIcon.edge.vCenter)
            .margin(indent).width(countLabelSize)
        viewsLabel.pin.right(2 * scalableIndent).vCenter(to: likesIcon.edge.vCenter)
            .width(countLabelSizeLarge)
        viewsIcon.pin.right(to: viewsLabel.edge.left).vCenter(to: likesIcon.edge.vCenter)
            .margin(indent).size(iconWidth)
        
    }
}


