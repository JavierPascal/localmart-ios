//
//  SignUpViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 02/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldRepeatedPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    @IBAction func createAccount(_ sender: Any) {
        // TODO: Validate fields
        
        // TODO: Create user
        let name = textfieldName.text!
        let email = textfieldEmail.text!
        let phone = textfieldPhone.text!
        let password = textfieldPassword.text!
        let repeatedPassword = textfieldRepeatedPassword!
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                print("Error creating user")
            }else{
                let fbDb = Firestore.firestore()
                
                fbDb.collection("users").document(result!.user.uid).setData([
                    "admin": false,
                    "email": email,
                    "name": name,
                    "phone": phone,
                ]) { (error) in
                    if error != nil {
                        print("Error adding user to cloud firestore")
                    }
                }
            
                // Transition to the home screen
                self.transitionToHome()
            }
        }
        
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeViewControllerID") as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
