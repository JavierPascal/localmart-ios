//
//  HomeViewController.swift
//  localmart-ios
//
//  Created by Jordan Gonzalez on 02/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    // products
    @IBOutlet weak var UserProductsCollectionView: UICollectionView!
    
    var products = [Product]()
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "UserProductViewCell"
    
    // user
    let preferences = UserDefaults.standard
    weak var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        UserProductsCollectionView.delegate = self
        UserProductsCollectionView.dataSource = self
        let nib = UINib(nibName: "UserProductViewCell", bundle: nil)
        UserProductsCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemsPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 8
            let interItemSpacing: CGFloat = 8
            
            let width = (UserProductsCollectionView.frame.width - (numberOfItemsPerRow - 1) * interItemSpacing) / numberOfItemsPerRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            UserProductsCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.products.removeAll()
        
        if let data = preferences.data(forKey: "user") {
            do {
                let fbDb = Firestore.firestore()
                let decoder = JSONDecoder()
                let temp = try decoder.decode(User.self, from: data)
                user = temp
                fbDb.collection("products").whereField("seller", isEqualTo: user.uid).getDocuments() {
                    (snapshot, error) in
                    
                    for document in snapshot!.documents {
                        let data = document.data()
                        let product =
                            Product(
                                name: data["name"] as! String,
                                description: data["description"] as! String,
                                image: data["image"] as! String,
                                price: String(format: "%.2f", data["price"] as! Float),
                                seller: data["seller"] as! String,
                                sold: data["sold"] as! Bool)
                        self.products.append(product)
                    }
                    
                    self.UserProductsCollectionView.reloadData()
                    
                }
                
                
            } catch {
                print("Unable to retrieve user")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UserProductViewCell
       
        
        cell.UserProductImageView.image = UIImage(named: "iphone")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
}
