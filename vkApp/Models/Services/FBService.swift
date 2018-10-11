//
//  FBService.swift
//  vkApp
//
//  Created by Olga Martyanova on 08/09/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import FirebaseDatabase
var requestHandler: DatabaseHandle?
var requestHandler1: DatabaseHandle?

class FBService {
    
    func writeUserToFB(fbObj: FBobject){
        var fbObjects = [FBobject]()
        let dbLink = Database.database().reference()
        requestHandler = dbLink.child("Users").observe(DataEventType.value, with:
            {   (snapshot) in
                guard let value = snapshot.value as? [Any] else {
                    fbObjects.append(fbObj)
                    let data = fbObjects.map{$0.toAnyObject}
                    dbLink.child("Users").setValue(data)
                    return
                }
                let users:[FBobject] = value.map { userJson in
                    guard let userJson = userJson as? [String: Any],
                        let idUser = userJson["idUser"] as? String
                        else {return FBobject(idUser: "")}
                    let idGroups = userJson["idGroups"] as? [String] ?? []
                    let user = FBobject(idUser: idUser, idGroups: idGroups)
                    return user
                }
                fbObjects = users
                if !fbObjects.contains(fbObj){
                    dbLink.child("Users").updateChildValues(["\(String(describing: fbObjects.count))": fbObj.toAnyObject])
                    
                }
        })
    }
    
    func writeGroupToFB(fbObj: FBobject, group: Group){
        var fbObjects = [FBobject]()
        var fbObject = fbObj
        let dbLink = Database.database().reference()
        requestHandler = dbLink.child("Users").observe(DataEventType.value, with:
            {   (snapshot) in
                guard let value = snapshot.value as? [Any] else {
                    return
                }
                let users:[FBobject] = value.map { userJson in
                    guard let userJson = userJson as? [String: Any],
                        let idUser = userJson["idUser"] as? String
                        else {return FBobject(idUser: "")}
                    let idGroups = userJson["idGroups"] as? [String] ?? []
                    let user = FBobject(idUser: idUser, idGroups: idGroups)
                    return user
                }
                fbObjects = users
                if let index = fbObjects.index(of: fbObject){
                    fbObject = fbObjects[index]
                    fbObject.addGroup(idGroup: String(group.id))
                    dbLink.child("Users").updateChildValues(["\(String(describing: index))": fbObject.toAnyObject])
                    
                }
        })
    }
}


