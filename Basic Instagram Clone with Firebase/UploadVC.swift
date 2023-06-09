//
//  UploadVC.swift
//  Basic Instagram Clone with Firebase
//
//  Created by Serhat  Şimşek  on 7.06.2023.
//

import UIKit
import Firebase
import FirebaseFirestore
class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageview: UIImageView!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var uploadUoutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageview.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadImageview.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        let pickerControl = UIImagePickerController()
        pickerControl.delegate = self
        pickerControl.sourceType = .photoLibrary
        present(pickerControl, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func alertMessage(title1:String, subtitle:String, alertButtonTitle:String){
        
        let alert = UIAlertController(title: title1, message: subtitle, preferredStyle: .alert)
        let okButton = UIAlertAction(title: alertButtonTitle, style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
     
    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadImageview.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString        // uniqe image name
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                            
                if error != nil {
                    self.alertMessage(title1: "Hata!", subtitle: error?.localizedDescription ?? "Error" , alertButtonTitle: "Tamam")
                } else {
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            let imageUrl = url!.absoluteString
                            print(imageUrl)
                            
                            // DB
                            
                            let fireStoreDatabase = Firestore.firestore()
                            var fireStoreReference : DocumentReference? = nil
                            let fireStorePost = ["imageUrl" : imageUrl, "postedBy":Auth.auth().currentUser!.email!, "postComment": self.commentTextfield.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            fireStoreReference = fireStoreDatabase.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                if error != nil{
                                    self.alertMessage(title1: "Hata!", subtitle: error?.localizedDescription ?? "hata8234", alertButtonTitle: "Tamam")
                                } else{
                                    
                                    self.uploadImageview.image = UIImage(named: "uploadLogo")
                                    self.commentTextfield.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                    
                                }
                            })
                            
                        }
                    }
                }
            }
            
        }
        
    }
    

}
