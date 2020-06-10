//
//  SettingsViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 10/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var buttonLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        do { try Auth.auth().signOut() }
        catch { print("already logged out" )}
        
        transitionToStart()
    }
    
    func transitionToStart() {
        let startViewController = storyboard?.instantiateViewController(identifier: "StartNavigationControllerID") as! UINavigationController
        
        view.window?.rootViewController = startViewController
        view.window?.makeKeyAndVisible()
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
