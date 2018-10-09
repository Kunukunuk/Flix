//
//  PosterCell.swift
//  Flix
//
//  Created by Kun Huang on 9/11/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Alamofire

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            if movie.posterUrl != nil {
                posterImageView.af_setImage(withURL: movie.posterUrl!)
            }
        }
    }
}
