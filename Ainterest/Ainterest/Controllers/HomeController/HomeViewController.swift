//
//  HomeViewController.swift
//  Ainterest
//
//  Created by user on 02/11/17.
//  Copyright © 2017 Arun's Technologies. All rights reserved.
//

import UIKit
import FileDownloadHelper

class HomeViewController: UIViewController {
    
    var postCollectionDataSource:PostCollectionDataSource? = nil
    var postCollectionDelegate:PostCollectionDelegate? = nil
    static var postsList:[PostDetails] = []
    var refreshControl:UIRefreshControl?
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge )
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !AppDelegate.isTesting(){
            initializePostCollectionView()
            setupPullToRefresh()
            initializeActivityIndicator()
            getPostDetails()
        }
        
    }
    
    func initializePostCollectionView(){
        if let layout = postCollectionView.collectionViewLayout as? PostsLayout {
            layout.delegate = self
        }
        postCollectionDataSource = PostCollectionDataSource()
        postCollectionDelegate = PostCollectionDelegate()
        postCollectionView.dataSource = postCollectionDataSource
        postCollectionView.delegate = postCollectionDelegate
        
    }
    
    func getPostDetails(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        APIController().getPostsDetails(completion: {postsList, error in
            HomeViewController.postsList = postsList!
            DispatchQueue.main.async {
                if self.refreshControl != nil{
                    self.refreshControl?.endRefreshing()
                }
                self.postCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        })
        
    }
    
    func setupPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshPostsCollection), for: .valueChanged)
        if #available(iOS 10.0, *) {
            postCollectionView.refreshControl = refreshControl
        } else {
            postCollectionView.addSubview(refreshControl!)
        }
    }
    
    func refreshPostsCollection(){
        getPostDetails()
    }
    
    func initializeActivityIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
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


extension HomeViewController : PostsLayoutDelegate {
    
    // 1. Returns the posts height
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
        let postDetail = HomeViewController.postsList[indexPath.item]
        return  CGSize(width: postDetail.imageWidth!, height: postDetail.imageHeight!)
    }
    
}
