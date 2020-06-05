//
//  ForgotPasswordViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 05/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var labelEmailError: UILabel!
    
    @IBOutlet weak var buttonRecoverPassword: UIButton!
    @IBOutlet weak var labelEmailSent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recoverPassword(_ sender: Any) {
        let error = validateFields()
        if !error {
            let email = textfieldEmail.text!
            Auth.auth().sendPasswordReset(withEmail: email){ (error) in
                if error == nil {
                    self.labelEmailSent.text = "Check your inbox to reset your password"
                }else{
                    self.labelEmailSent.text = "An error occured, try again later"
                }
            }
        }
    }
    
    func validateFields() -> Bool{
        var error = false
        let email = textfieldEmail.text
        labelEmailError.text = ""
        // Check all fields are valid
        if email?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            labelEmailError.text = "Enter your email"
            error = true
        }else if !isValidEmail(email!){
            labelEmailError.text = "Invalid email"
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
        
        // Button
        buttonRecoverPassword.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonRecoverPassword.layer.cornerRadius = 5
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
