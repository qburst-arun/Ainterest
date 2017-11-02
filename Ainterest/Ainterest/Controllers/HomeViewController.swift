//
//  HomeViewController.swift
//  Ainterest
//
//  Created by user on 02/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var postCollectionDataSource:PostCollectionDataSource? = nil
    var postCollectionDelegate:PostCollectionDelegate? = nil
    @IBOutlet weak var postCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionDataSource = PostCollectionDataSource()
        postCollectionDelegate = PostCollectionDelegate()
        
        homeCollectionView.dataSource = homeCollectionDataSource
        homeCollectionView.delegate = homeCollectionDelegate
        
        homeCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
