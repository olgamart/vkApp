//
//  Group.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Group: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var numbers: Int = 0
    
    convenience init(json: JSON) {
        self.init()
            self.id = json["id"].intValue
            self.name = json["name"].stringValue
            self.avatar = json["photo_50"].stringValue
            self.numbers = json["members_count"].intValue
    }
    static func == (lhs:Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
    
}

