//
//  ProfileViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 10/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    
    let preferences = UserDefaults.standard
    weak var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        user = preferences.object(forKey: "user") as? User
        labelUsername.text = user.name + " " + user.lastname
        labelEmail.text = user.email
        labelPhone.text = user.phone
        // Do any additional setup after loading the view.
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
