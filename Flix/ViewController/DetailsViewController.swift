//
//  DetailsViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/11/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

enum MovieKey {
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}
class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDatelabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie[MovieKey.title] as? String
            releaseDatelabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            
            let backdropPath = movie[MovieKey.backdropPath] as! String
            let posterPath = movie[MovieKey.posterPath] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURL + backdropPath)!
            let posterURL = URL(string: baseURL + posterPath)!
            
            backDropImageView.af_setImage(withURL: backdropURL)
            posterImageView.af_setImage(withURL: posterURL)
            
            
        }
        
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