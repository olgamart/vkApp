//
//  PhotosViewController.swift
//  vkApp
//
//  Created by Olga Martyanova on 22/07/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosViewController: UICollectionViewController {
    var token = String()
   // var photos = [Photo]()
    var photos: Results<Photo>!
    var tokenRealm: NotificationToken?
    var friend:Friend?

    override func viewDidLoad() {
        super.viewDidLoad()
        networkRequest(token: token)
        pairTableAndRealm()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.setup (with: photo)        
        return cell
    }
    
    func networkRequest(token: String) {
        let vkService = VKService(token: token)
        if let friend = friend {
            vkService.getPhotos(friendId: friend.id)
        }
    }
    
    
    
    func pairTableAndRealm(){
        guard let realm = try? Realm() else {return}
        photos = realm.objects(Photo.self)
        tokenRealm = photos?.observe {[weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else {return}
            switch changes {
            case .initial:
                collectionView.reloadData()
                break
            case .update (_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates ({
                    collectionView.insertItems(at: insertions.map({IndexPath(row: $0, section: 0)}))
                    collectionView.deleteItems(at: deletions.map({IndexPath(row: $0, section: 0)}))
                    collectionView.reloadItems(at: modifications.map({IndexPath(row: $0, section: 0)}))
                }, completion: nil)
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }    
}
