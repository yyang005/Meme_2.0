//
//  Meme.swift
//  MemeMe
//
//  Created by ying yang on 2/26/16.
//  Copyright © 2016 ying yang. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topString: String
    var bottomString: String
    var originalImage: UIImage
    var memeImage: UIImage
    
    init (top: String, bottom: String, originalImg: UIImage, memeImg: UIImage){
        topString = top;
        bottomString = bottom
        originalImage = originalImg
        memeImage = memeImg
    }
}