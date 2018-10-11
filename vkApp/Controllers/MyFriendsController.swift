//
//  MyFriendsController.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyFriendsController: UITableViewController {
    var token = String()
    var id = String()
    var friends: Results<Friend>!
    var tokenRealm: NotificationToken?    
    
   
    override func viewDidLoad() {
        let barColor = UIColor(red: CGFloat(0.96), green: CGFloat(0.96), blue: CGFloat(0.96), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = barColor
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = barColor       
        
        networkRequest(token: token)
        pairTableAndRealm()
        saveUserIdToFB()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        
        return  friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! MyFriendsCell
        let friend = friends[indexPath.row]
        cell.setup(with: friend)
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let conroller = segue.destination as? PhotosViewController{
            if let path = tableView.indexPathForSelectedRow {
            conroller.friend = friends[path.row]
            conroller.token = token
            }
        }
    }
    
    func networkRequest(token: String) {
        let vkService = VKService(token: token)
        vkService.getFriends()
    }
    
    func pairTableAndRealm(){
        guard let realm = try? Realm() else {return}
        friends = realm.objects(Friend.self)
        tokenRealm = friends?.observe {[weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else {return}
            switch changes {
            case .initial:
                tableView.reloadData()
                break
            case .update (_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.deleteRows(at: deletions.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map ({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    func saveUserIdToFB(){
        let fbObject = FBobject(idUser: id)
        let fbService = FBService()
        fbService.writeUserToFB(fbObj: fbObject)
    }

    
}
