//
//  ViewController.swift
//  Basic Instagram Clone with Firebase
//
//  Created by Serhat  Şimşek  on 7.06.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var userPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameTextfield.text != "" && userPasswordTextfield.text != "" {
            
            Auth.auth().signIn(withEmail: usernameTextfield.text!, password: userPasswordTextfield.text!) { authData, error in
                
                if error != nil{
                    self.alertMessage(title1: "Hata!", subtitle: error?.localizedDescription ?? "hata1427", alertButonTitle: "Tamam")
                } else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            alertMessage(title1: "Hata!", subtitle: "Alanlar boş bırakılamaz..", alertButonTitle: "Tamam")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if usernameTextfield.text != "" && userPasswordTextfield.text != ""{
            Auth.auth().createUser(withEmail: usernameTextfield.text!, password: userPasswordTextfield.text!) { authData, error in
                
                if error != nil{
                    self.alertMessage(title1: "Hata!", subtitle: error?.localizedDescription ?? "error1021", alertButonTitle: "Ok")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
        } else {
            alertMessage(title1: "Hata!", subtitle: "Alanlar boş bırakılamaz..", alertButonTitle: "Tamam")
        }
    }
    
    
    
    
    func alertMessage(title1:String, subtitle:String, alertButonTitle:String){   // çok sık
        
        let alert = UIAlertController(title: title1, message: subtitle, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: alertButonTitle, style: .default)
        alert.addAction(alertButton)
        self.present(alert, animated: true)
        
    }
}

