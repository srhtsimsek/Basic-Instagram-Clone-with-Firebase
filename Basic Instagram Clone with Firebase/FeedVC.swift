//
//  FeedVC.swift
//  Basic Instagram Clone with Firebase
//
//  Created by Serhat  Şimşek  on 7.06.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    var userNameArray = [String]()
    var likeArray = [Int]()
    var userCommentArray = [String]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFireStore()
        
    }
    

    func getDataFireStore(){
        
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    // tableview  iki defa gösterilmesin diye
                    self.userImageArray.removeAll()
                    self.userNameArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.likeArray.removeAll()
                    
                    for document in snapshot!.documents{
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userNameArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        
                        if let userImage = document.get("imageUrl") as? String{
                            self.userImageArray.append(userImage)
                        }
                        
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
        /*
        var settings = fireStoreDB.settings
        settings.areTimestamspInSnapshotsEnabled = true
        fireStoreDB.settings = settings
         */
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FeedCell
        cell.userNameEmail.text = userNameArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        return cell
    }
    
    
}


