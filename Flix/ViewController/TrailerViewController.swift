//
//  TrailerViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/16/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var videoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoviesTrailer(of: videoID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo(of key: String) {
        
        if let videoURL:URL = URL(string: "https://www.youtube.com/watch?v=\(key)") {
            webView.load(URLRequest(url: videoURL))
        }
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchMoviesTrailer(of movieID: String) {
        
        print("in fetchMovies \(movieID)")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                //self.alert()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let trailers = dataDictionary["results"] as! [[String: Any]]
                let youtubeKey = trailers[0]["key"] as! String
                self.playVideo(of: youtubeKey)
                
            }
        }
        task.resume()
    }

}
