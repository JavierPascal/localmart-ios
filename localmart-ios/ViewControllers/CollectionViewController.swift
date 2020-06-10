//
//  CollectionViewController.swift
//  localmart-ios
//
//  Created by Javier Pascal Flores on 10/06/20.
//  Copyright © 2020 Javier Pascal. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let products = ["iPhone 11 Pro Max", "MacBook Pro 16in", "Oculus", "Kindle Paperwhite", "Pixel 4", "Playstation 4", "Xbox One", "Philips Hue"]
    
    let productImages = [ #imageLiteral(resourceName: "iphone"), #imageLiteral(resourceName: "macbook"), #imageLiteral(resourceName: "oculus"), #imageLiteral(resourceName: "kindle"), #imageLiteral(resourceName: "pixel"), #imageLiteral(resourceName: "ps4"), #imageLiteral(resourceName: "xbox"), #imageLiteral(resourceName: "hue")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/2, height: self.collectionView.frame.size.height/3)
    }

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.productLabel.text = products[indexPath.item]
        cell.productImageView.image = productImages[indexPath.item]
        
        return cell
        
    }
    
    
}
