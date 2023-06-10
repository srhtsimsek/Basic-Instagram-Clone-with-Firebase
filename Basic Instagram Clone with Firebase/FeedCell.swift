//
//  FeedCell.swift
//  Basic Instagram Clone with Firebase
//
//  Created by Serhat  Şimşek  on 10.06.2023.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameEmail: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var documentIdLabel: UILabel!
    @IBOutlet weak var likeButtonOutlet: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        documentIdLabel.isHidden = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        
        let fireStoreDB = Firestore.firestore()
      
            if let likeSum = Int(likeLabel.text!){
                let likeStore = ["likes": likeSum + 1] as [String: Any]
                fireStoreDB.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
                likeButtonOutlet.setImage(UIImage(named: "redLike"), for: .normal)
                
            }
    }
 
}

