//
//  MyGroupsController.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//


import UIKit
import RealmSwift


class MyGroupsController: UITableViewController {
    var token = String()
     var id = String()
    var myGroups: Results<Group>!
    var tokenRealm: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barColor = UIColor(red: CGFloat(0.96), green: CGFloat(0.96), blue: CGFloat(0.96), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = barColor
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = barColor
        
        networkRequest(token: token)
        pairTableAndRealm()
    }    
   
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {let cell = tableView.dequeueReusableCell(withIdentifier: "MyGroupCell", for: indexPath) as! MyGroupCell
        let myGroup = myGroups[indexPath.row]
        cell.setup (with: myGroup)
        return cell
    }
    @IBAction func addGroup(segue: UIStoryboardSegue){
        if segue.identifier == "addGroup"{
            if let groupsController = segue.source as? GroupsController,
                let indexPath = groupsController.tableView.indexPathForSelectedRow{
                let group = groupsController.groups[indexPath.row]
                
                if !myGroups.contains(group) {
                    addGroupToRealm(newGroup: group)
                    saveGroupIdToFB(addGroup: group)
                }
            }
        }
    }
    
    private func addGroupToRealm(newGroup: Group){
        do{
            let realm = try Realm()
            realm.beginWrite()
            realm.add(newGroup)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let myGroup = myGroups?[indexPath.row], editingStyle == .delete {            
            do{
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(myGroup)
                try realm.commitWrite()                
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let conroller = segue.destination as? GroupsController {
                conroller.token = token
        }
    }
    
    func networkRequest(token: String) {
        let vkService = VKService(token: token)
        vkService.getGroups()     
    }

    func pairTableAndRealm(){
        guard let realm = try? Realm() else {return}
        myGroups = realm.objects(Group.self)
        tokenRealm = myGroups?.observe {[weak self] (changes: RealmCollectionChange) in
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
    
    func saveGroupIdToFB(addGroup: Group){
        let fbObject = FBobject(idUser: id)
        let fbService = FBService()
        fbService.writeGroupToFB(fbObj: fbObject, group: addGroup)
    }

}

