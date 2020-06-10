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
    
    var commArr = ["Tec Cem", "Twitter CDMX", "Arboledas"]
    var adsArr = ["500 listings", "50 listings", "2000 listings" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension CommunitiesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commCell", for: indexPath)
        
        let index = indexPath.row
        cell.textLabel?.text = commArr[index]
        let subtitle = adsArr[index]
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
}
