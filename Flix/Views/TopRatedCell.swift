//
//  TopRatedCell.swift
//  Flix
//
//  Created by Kun Huang on 9/17/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class TopRatedCell: UICollectionViewCell {
    
    @IBOutlet weak var topRatedImage: UIImageView!
    
    var movie: Movie! {
        didSet {
            if movie.posterUrl != nil {
                topRatedImage.af_setImage(withURL: movie.posterUrl!)
            }
        }
    }
}
