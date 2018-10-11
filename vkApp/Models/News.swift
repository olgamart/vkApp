//
//  News.swift
//  vkApp
//
//  Created by Olga Martyanova on 19/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import SwiftyJSON

class News {
    var groups = [Group]()
    var friends = [Friend]()
    var type: String = ""
    var id: Int = 0
    var first_name: String = ""
    var last_name: String = ""
    var name: String = ""
    var avatar: String = ""
    var text: String = ""
    var likes: Int = 0
    var reposts: Int = 0
    var comments: Int = 0
    var views: Int = 0
    var photoUrl: String = ""
    var author: String = ""    
    
    init(json: JSON, groups:[Group], friends:[Friend]) {
        self.type = json["type"].stringValue
        self.id = json["source_id"].intValue
        self.text = json["text"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.comments = json["comments"]["count"].intValue
        self.views = json["views"]["count"].intValue
        self.photoUrl = json["photos"]["items"][0]["sizes"][4]["url"].stringValue
        if self.id > 0 {
            let friend = friends.filter{$0.id == self.id}
            self.author = friend[0].first_name + " " + friend[0].last_name
            self.avatar = friend[0].avatar
        } else {
            let group = groups.filter{$0.id == abs(self.id)}
            self.author = group[0].name
            self.avatar = group[0].avatar
        }
    }
}
