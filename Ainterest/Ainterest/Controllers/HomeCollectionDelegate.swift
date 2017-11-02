//
//  HomeCollectionDelegate.swift
//  Ainterest
//
//  Created by user on 02/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import Foundation
import UIKit

public class HomeCollectionDelegate: NSObject, UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate protocol
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
