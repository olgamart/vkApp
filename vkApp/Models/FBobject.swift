//
//  FBobject.swift
//  vkApp
//
//  Created by Olga Martyanova on 05/09/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import SwiftyJSON

class FBobject: Equatable {
    
    var idUser: String
  var idGroups: [String] = []
//    var idGroups: [String] = ["12345", "33333", "77777"]
    var toAnyObject: Any {
        return [
            "idUser": idUser,
            "idGroups": idGroups
        ]
    }
    init(idUser: String) {
        self.idUser = idUser
    }
    
    init(idUser: String, idGroups: [String]) {
        self.idUser = idUser
        self.idGroups = idGroups
    }
    
    static func == (lhs:FBobject, rhs: FBobject) -> Bool {
        return lhs.idUser == rhs.idUser
    }
    
    func addGroup (idGroup: String){
        if !idGroups.contains(idGroup){
        idGroups.append(idGroup)
        }
    } 
    
}

