//
//  HomeCollectionDataSource.swift
//  Ainterest
//
//  Created by user on 02/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
import UIKit

public class PostCollectionDataSource: NSObject, UICollectionViewDataSource {

    let reuseIdentifier = "PostCollectionCell" // also enter this string as the cell identifier in the storyboard
    var items = [100, 200, 50, 80, 105, 164, 78, 200, 312, 74]

    override init() {
    }
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PostCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.postImageView.image = UIImage(named: "post")
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
}


