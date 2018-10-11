//
//  VKService.swift
//  vkApp
//
//  Created by Olga Martyanova on 29/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKService {
    let token: String
    var url = "https://api.vk.com/method/"
    let version = "5.80"
    
    init(token:String) {
        self.token = token
    }
    
    func getFriends() {
       
        let method = "friends.get"
        url += method
        let parameters: Parameters = [
            "fields": "nickname,photo_50",
            "access_token": token,
            "v": version
        ]
      Alamofire.request(url, method: .get, parameters: parameters).responseData (queue: DispatchQueue.global()){ respons in            guard let data = respons.value else {return}
            if let json = try? JSON(data: data){
            let friends = json["response"]["items"].compactMap{Friend(json: $0.1)}
            VKDataBD.saveData(saveObjects: friends, type: Friend.self)
        }
    }
}
    
    func getGroups() {
        let method = "groups.get"
        url += method
        let parameters: Parameters = [
            "extended": "1",
            "fields": "name,photo_50,members_count",
            "access_token": token,
            "v": version
        ]
       
         Alamofire.request(url, method: .get, parameters: parameters).responseData (queue: DispatchQueue.global()){ respons in
            guard let data = respons.value else {return}
            if let json = try? JSON(data: data){
              let  groups = json["response"]["items"].compactMap{Group(json: $0.1)}
                VKDataBD.saveData(saveObjects: groups, type: Group.self)
            }
        }
    }
    
    func getNews(completion: @escaping ([News]) -> Void) {
        let method = "newsfeed.get"
        url += method
        let parameters: Parameters = [
            "filters": "post,wall_photo",
            "fields": "name,first_name,last_name,photo_50",
            "access_token": token,
            "v": version
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseData (queue: DispatchQueue.global()){ respons in
            guard let data = respons.value else {return}
            if let json = try? JSON(data: data){
                let groups = json["response"]["groups"].compactMap{Group(json: $0.1)}
                let friends = json["response"]["profiles"].compactMap{Friend(json: $0.1)}
                let news = json["response"]["items"].compactMap{News(json: $0.1, groups: groups, friends: friends )}
                DispatchQueue.main.async {
                completion(news)
                }
            }
        }
    }
    
    func getPhotos(friendId:Int) {
        let method = "photos.getAll"
        let id = String(friendId)
        url += method
        let parameters: Parameters = [
            "owner_id": id,
            "access_token": token,
            "v": version
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseData (queue: DispatchQueue.global()){ respons in
            guard let data = respons.value else {return}
            if let json = try? JSON(data: data){
                let photos = json["response"]["items"].compactMap{Photo(json: $0.1)}
                VKDataBD.saveData(saveObjects: photos, type: Photo.self)
            }
        }
    }
    
    
    func searchGroups(searchStr: String, completion: @escaping ([Group]) -> Void) {
        let method = "groups.search"
        url += method
        let parameters: Parameters = [
            "fields": "name,photo_50,members_count",
            "q": searchStr,
            "access_token": token,
            "v": version
        ]
         Alamofire.request(url, method: .get, parameters: parameters).responseData (queue: DispatchQueue.global()){ respons in
            guard let data = respons.value else {return}
            if let json = try? JSON(data: data){
                let groups = json["response"]["items"].compactMap{Group(json: $0.1)}
                DispatchQueue.main.async {
                completion(groups)
                }
            }
        }
    }
}
