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
    var itemsHieght = [100, 200, 520, 80, 105, 164, 78, 200, 312, 74]
    var itemsWidth = [100, 400, 350, 40, 125, 100, 100, 150, 400, 50]
    var postCollectionDataSource:PostCollectionDataSource? = nil
    var postCollectionDelegate:PostCollectionDelegate? = nil
    @IBOutlet weak var postCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        test()
        if let layout = postCollectionView.collectionViewLayout as? PostsLayout {
            layout.delegate = self
        }
        
        postCollectionDataSource = PostCollectionDataSource()
        postCollectionDelegate = PostCollectionDelegate()
        
        postCollectionView.dataSource = postCollectionDataSource
        postCollectionView.delegate = postCollectionDelegate
        
        postCollectionView.reloadData()
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
    
    @IBAction func testDownload(_ sender: Any) {
        
        let progress = {(progress:Float) -> (Void) in
            NSLog("progress:- \(progress)");
        }
        let completion = {(success:DefaultDownloadResponse) -> (Void) in
            NSLog("success:- \(success)");
            let image = UIImage(data:success.data!,scale:1.0)
            NSLog("success:- \(success)");
        }
        let url = URL.init(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
        
        //        let url = URL.init(string: "http://www.otc.umd.edu/sites/default/files/documents/sample-license.pdf")
        let downloadTask = FileDownloadHelper(withUrl: url!, Progress: progress, Completion: completion)
        downloadTask.startDownload()
        
    }
//    func test(){
//        let progress = {(progress:Float) -> (Void) in
//            NSLog("progress:- \(progress)");
//        }
//        let completion = {(success:DefaultDownloadResponse) -> (Void) in
//            NSLog("success:- \(success)");
//            let image = UIImage(data:success.data!,scale:1.0)
//            NSLog("success:- \(success)");
//        }
//        let url = URL.init(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
//
////        let url = URL.init(string: "http://www.otc.umd.edu/sites/default/files/documents/sample-license.pdf")
//
//        FileDownloadHelper.sharedInstance.startDownload(FromURL: url!, withProgress:progress, withCompleteion: completion )
    
//    }
    func testCancel(){
        let url = URL.init(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5\u{0026}q=80\u{0026}fm=jpg\u{0026}crop=entropy\u{0026}s=4b142941bfd18159e2e4d166abcd0705")
        
        //        let url = URL.init(string: "http://www.otc.umd.edu/sites/default/files/documents/sample-license.pdf")
        
//        FileDownloadHelper.sharedInstance.cancelDownload(FromURL:url)
    }

}


extension HomeViewController : PostsLayoutDelegate {
    
    // 1. Returns the photo height
    func collectionView(_ collectionView: UICollectionView, sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize {
        return  CGSize(width: itemsWidth[indexPath.item], height: itemsHieght[indexPath.item])
    }
    
}
