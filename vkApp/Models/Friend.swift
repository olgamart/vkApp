//
//  Friend.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friend: Object {
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var avatar: String = ""
    
   convenience init(json: JSON) {
    self.init()
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.id = json["id"].intValue
        self.avatar = json["photo_50"].stringValue
    }
}
