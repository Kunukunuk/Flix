//
//  DetailsViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/11/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDatelabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        
        
        titleLabel.text = movie?.title
        releaseDatelabel.text = movie?.releaseDate
        overviewLabel.text = movie?.overview
        if movie?.posterUrl != nil {
            posterImageView.af_setImage(withURL: (movie?.posterUrl!)!)
        }
        if movie?.backdropURL != nil {
            backDropImageView.af_setImage(withURL: (movie?.backdropURL!)!)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailer = segue.destination as! TrailerViewController
        trailer.videoID = "\((movie?.id)!)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
