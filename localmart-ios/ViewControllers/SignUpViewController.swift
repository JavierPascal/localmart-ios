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
    
    @IBOutlet weak var labelNameError: UILabel!
    @IBOutlet weak var labelEmailError: UILabel!
    @IBOutlet weak var labelPhoneError: UILabel!
    @IBOutlet weak var labelPasswordError: UILabel!
    @IBOutlet weak var labelRepeatedPasswordError: UILabel!
    
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var buttonBackLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.left")
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAccount(_ sender: Any) {

        self.labelEmailError.text = ""

        let name = textfieldName.text!
        let email = textfieldEmail.text!
        let phone = textfieldPhone.text!
        let password = textfieldPassword.text!
        
        let error = self.validateFields()
        
        if !error {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    let errorCode = AuthErrorCode(rawValue: error!._code)
                    switch errorCode {
                        case .emailAlreadyInUse:
                            self.labelEmailError.text = "Email already in use"
                        default:
                            print("Unknown error occurred")
                    }
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
        
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeTabBarControllerID") as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func validateFields() -> Bool{
        var error = false
        let name = textfieldName.text
        let email = textfieldEmail.text
        let phone = textfieldPhone.text
        let password = textfieldPassword.text
        let repeatedPassword = textfieldRepeatedPassword.text
        labelEmailError.text = ""
        labelNameError.text = ""
        labelPhoneError.text = ""
        labelPasswordError.text = ""
        labelRepeatedPasswordError.text = ""
        
        
        // Check all fields are valid
        // Name
        if name?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelNameError.text = "Enter your name"
            error = true
        }else if !((name?.containsWhiteSpace())!) {
            labelNameError.text = "Lastname required"
            error = true
        }
        
        // Email
        if email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelEmailError.text = "No email detected"
            error = true
        }else if !isValidEmail(email!){
            labelEmailError.text = "Invalid email"
            error = true
        }
        
        // Phone
        if phone?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelPhoneError.text = "Enter your phone number"
            error = true
        }else if !(phone?.isNumeric())! {
            labelPhoneError.text = "Invalid phone number"
            error = true
        }
    
        // Password
        
        if password?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelPasswordError.text = "Enter your password"
            error = true
        }else if password!.count < 6 {
            labelPasswordError.text = "Password must be 6 characters long"
            error = true
        }
        
        if repeatedPassword?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelRepeatedPasswordError.text = "No password found"
            error = true
        }else if repeatedPassword != password {
            labelRepeatedPasswordError.text = "Passwords do not match"
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
        textfieldRepeatedPassword.heightAnchor.constraint(equalToConstant: 42).isActive = true
        textfieldPhone.heightAnchor.constraint(equalToConstant: 42).isActive = true
        textfieldName.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        // Button
        buttonSignUp.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonSignUp.layer.cornerRadius = 5
    }
    
    

}

extension String {

    func containsWhiteSpace() -> Bool {

        // check if there's a range for a whitespace
        let range = self.rangeOfCharacter(from: .whitespacesAndNewlines)

        // returns false when there's no range for whitespace
        if let _ = range {
            return true
        } else {
            return false
        }
    }
    
    func isNumeric() -> Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
