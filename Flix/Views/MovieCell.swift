//
//  MovieCell.swift
//  Flix
//
//  Created by Kun Huang on 9/5/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Alamofire

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var moviePosterImage: UIImageView!
    var movie: Movie! {
        didSet{
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            if movie.posterUrl != nil {
                moviePosterImage.af_setImage(withURL: movie.posterUrl!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
