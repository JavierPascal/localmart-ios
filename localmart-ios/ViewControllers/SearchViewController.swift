//
//  SearchViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 03/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    @IBOutlet weak var tableSearch: UITableView!
    
    var arrCategories: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fbDb = Firestore.firestore()
        if arrCategories.isEmpty{
            fbDb.collection("categories").getDocuments() {
                (snapshot, error) in
                
                for document in snapshot!.documents {
                    self.arrCategories.append(document.data()["name"] as! String)
                }
                self.tableSearch.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath)
        
        cell.textLabel?.text = arrCategories[indexPath.row]
        
        return cell
    }
    
    
}
