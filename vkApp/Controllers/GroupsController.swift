//
//  GroupsController.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit


class GroupsController: UITableViewController {
    var token = String()
    
    @IBOutlet weak var searchBar: UISearchBar!
 
    var groups = [Group]()
    var filteredGroups:[Group]?

    override func viewDidLoad() {
        super.viewDidLoad()
  
        filteredGroups = groups
        self.tableView.reloadData()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
       let group = groups[indexPath.row]
            cell.setup(with: group)
        return cell
    }
}




extension GroupsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        view.endEditing(true)
        if let search = searchBar.text {
            networkRequest(token: token, searchStr: search)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            groups = filteredGroups!
            tableView.reloadData()
            return
        }
        groups = filteredGroups!.filter{ (group) -> Bool in
            group.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
        
    }
    
    func networkRequest(token: String, searchStr: String) {
        let vkService = VKService(token: token)
        vkService.searchGroups(searchStr: searchStr){[weak self] groups in    
            self?.groups = groups
            self?.tableView?.reloadData()
        }
    }
}

 

