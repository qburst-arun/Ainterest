//
//  HomeCollectionDataSource.swift
//  Ainterest
//
//  Created by user on 02/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
import UIKit
import FileDownloadHelper

public class PostCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let reuseIdentifier = "PostCollectionCell" // also enter this string as the cell identifier in the storyboard
    
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return HomeViewController.postsList.count
    }
    
    // make a cell for each cell index path
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PostCollectionViewCell
        
        let imageUrl = HomeViewController.postsList[indexPath.item].imageUrl!
        let downloadTask = FileDownloadHelper(withUrl:imageUrl , Progress: {progress in
        }, Completion: {response in
            if response.error == nil{
                DispatchQueue.main.async {
                    if let image = UIImage(data:response.data!,scale:1.0)     {
                        if let cellNew: PostCollectionViewCell = collectionView.cellForItem(at: indexPath) as? PostCollectionViewCell {
                            cellNew.postImageView.image = image
                        }else{
                            cell.postImageView.image = image
                        }
                    }else{
                        print("Image load failed due to invalid data")
                    }
                };
            }else{
                print("Download Failed: ",response.error!)
            }
        })
        cell.postImageView.image = nil
        downloadTask.startDownload()
        
        return cell
    }
    
}


