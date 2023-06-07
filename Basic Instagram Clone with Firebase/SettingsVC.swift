//
//  SettingsVC.swift
//  Basic Instagram Clone with Firebase
//
//  Created by Serhat  Şimşek  on 7.06.2023.
//

import UIKit

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
   

}
