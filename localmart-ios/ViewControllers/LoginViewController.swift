//
//  LoginViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 02/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func login(_ sender: Any) {
        // TODO: Validate fields
        
        // Clean versions of fields
        let email = textfieldEmail.text!
        let password = textfieldPassword.text!
        
        // Sign in with user
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            if error != nil {
                print("Error signing in")
            }else{
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
