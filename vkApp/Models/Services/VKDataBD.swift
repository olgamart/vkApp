//
//  VKDataBD.swift
//  vkApp
//
//  Created by Olga Martyanova on 05/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import RealmSwift
class VKDataBD { 
    
    class func saveData (saveObjects: [Object], type: Object.Type){
        do {
 //         let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
 //         let realm = try Realm(configuration: config)
            let realm = try! Realm()
            let oldData = realm.objects(type)
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(saveObjects)
            try realm.commitWrite()
            
        } catch {
            print(error)
        } 
    }
    
    class func loadData(type: Object.Type) -> [Object]{
          let realm = try! Realm()
            let loadObjects = realm.objects(type)
            return Array(loadObjects)
    }
}

