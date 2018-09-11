//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/10/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var Overview: UILabel!
    
    var mtitle = ""
    var overview = ""
    var backdropURL = ""
    var posterURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = mtitle
        Overview.text = overview
        
        backdropImage.af_setImage(withURL: URL(string: backdropURL)!)
        posterImage.af_setImage(withURL: URL(string: posterURL)!)
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

}
