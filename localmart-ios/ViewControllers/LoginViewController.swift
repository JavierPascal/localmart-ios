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
    @IBOutlet weak var labelEmailError: UILabel!
    @IBOutlet weak var labelPasswordError: UILabel!
    
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        // TODO: Validate fields
        
        // Clean versions of fields
        let email = textfieldEmail.text!
        let password = textfieldPassword.text!
        
        let error = self.validateFields()
        if !error {
            // Sign in with user
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if error != nil {
                    self.labelPasswordError.text = "Invalid credentials"
                }else{
                    self.transitionToHome()
                }
            }
        }
        
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeTabBarControllerID") as! UITabBarController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func validateFields() -> Bool{
        var error = false
        let email = textfieldEmail.text
        let password = textfieldPassword.text
        labelEmailError.text = ""
        labelPasswordError.text = ""
        
        // Check all fields are valid
        if email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelEmailError.text = "No email detected"
            error = true
        }else if !isValidEmail(email!){
            labelEmailError.text = "Invalid email"
            error = true
        }
        
        if password?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelPasswordError.text = "Enter your password"
            error = true
        }
        
        return error
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setupUI(){
        // Textfields
        textfieldEmail.heightAnchor.constraint(equalToConstant: 42).isActive = true
        textfieldPassword.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        // Button
        buttonLogin.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonLogin.layer.cornerRadius = 5
    }

}
