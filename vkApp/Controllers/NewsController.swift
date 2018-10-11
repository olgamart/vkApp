//
//  NewsController.swift
//  vkApp
//
//  Created by Olga Martyanova on 16/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import RealmSwift


class NewsController: UITableViewController {
    var token = String()
    var news = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let barColor = UIColor(red: CGFloat(0.96), green: CGFloat(0.96), blue: CGFloat(0.96), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = barColor
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.barTintColor = barColor 
        
        networkRequest(token: token)
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myNew = news[indexPath.row]
        var cell = UITableViewCell()
        if myNew.type == "post" {
    let   cellPost = tableView.dequeueReusableCell(withIdentifier: "NewsCellPost", for: indexPath) as! NewsCellPost
        cellPost.setup(with: myNew)
         cell = cellPost
        } else {
        let cellPhoto = tableView.dequeueReusableCell(withIdentifier: "NewsCellPhoto", for: indexPath) as! NewsCellPhoto
        cellPhoto.setup(with: myNew)
        cell = cellPhoto
        }
        return cell
    }
    
    func networkRequest(token: String) {
        
        let service = VKService(token: token)
        service.getNews(){[weak self] news in
            self?.news = news
            self?.tableView.reloadData()
        }
    }

}
