//
//  CommunitiesViewController.swift
//  localmart-ios
//
//  Created by Javier Pascal Flores on 03/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit

class CommunitiesViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let preferences = UserDefaults.standard
    weak var user: User!
    
    var communities = [String]()
    var adsArr = ["500 listings", "50 listings", "2000 listings" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = preferences.data(forKey: "user") {
            do {
                let decoder = JSONDecoder()
                let temp = try decoder.decode(User.self, from: data)
                user = temp
                communities = user.communities
                
            } catch {
                print("Unable to retrieve user")
            }
        }
    }
    

}

extension CommunitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commCell", for: indexPath)
        
        let index = indexPath.row
        cell.textLabel?.text = communities[index]
        let subtitle = "" //adsArr[index]
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
}
