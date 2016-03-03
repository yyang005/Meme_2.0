//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by ying yang on 3/2/16.
//  Copyright © 2016 ying yang. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = image
        imageView.contentMode = .ScaleAspectFit
    }
}
