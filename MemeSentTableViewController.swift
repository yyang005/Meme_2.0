//
//  MemeSentTableViewController.swift
//  MemeMe
//
//  Created by ying yang on 2/29/16.
//  Copyright © 2016 ying yang. All rights reserved.
//

import UIKit
import Foundation

class MemeSentTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var meme: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).meme
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if meme.count > 0 {
            //let indexPaths = NSIndexPath(forRow: meme.count-1, inSection: 0)
            //tableView.insertRowsAtIndexPaths([indexPaths], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meme.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath)
        cell.imageView!.image = meme[indexPath.row].memeImage
        cell.textLabel!.text = meme[indexPath.row].topString + meme[indexPath.row].bottomString
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetail") as! MemeDetailViewController
        vc.image = meme[indexPath.row].memeImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
