//
//  MemeSentCollectionViewController.swift
//  MemeMe
//
//  Created by ying yang on 3/1/16.
//  Copyright © 2016 ying yang. All rights reserved.
//

import UIKit

class MemeSentCollectionViewController: UICollectionViewController {
    var meme: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).meme
    }
    
    @IBOutlet var memeSentCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meme.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeSentCell", forIndexPath: indexPath) as! MemeSentCell
        cell.imageView.image = meme[indexPath.item].memeImage
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetail") as! MemeDetailViewController
        vc.image = meme[indexPath.item].memeImage
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
            memeSentCollectionView.reloadData()
            self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimensionX = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionY = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimensionX, dimensionY)
    }
}
