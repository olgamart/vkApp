//
//  Photo.swift
//  vkApp
//
//  Created by Olga Martyanova on 02/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//


import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
@objc dynamic var photoUrl: String = ""
@objc dynamic var photoHeight: Int = 0
@objc dynamic var photoWidht: Int = 0
    
 convenience init(json: JSON) {
    self.init()
        self.photoUrl = json["sizes"][2]["url"].stringValue    
    }    
}
