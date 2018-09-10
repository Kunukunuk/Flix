//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/5/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [[String: Any]] = []
    var filteredData: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        searchBar.delegate = self

        tableView.dataSource = self
        
        fetchMovies()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredData = movies.filter {
                 ($0["title"] as! String).lowercased().contains(searchText.lowercased())
            }
            
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        isSearching = false
        tableView.reloadData()
    }
    
    
    func alert() {
        let alertController = UIAlertController(title: "Can not get the movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Try Again", style: .default, handler: {UIAlertAction in self.fetchMovies()})
        alertController.addAction(OKAction)
        tableView.addSubview(alertController.view)
        present(alertController, animated: true)
    }
    
    func fetchMovies() {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                self.alert()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activity.stopAnimating()
                self.filteredData = self.movies
                
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching) {
            return filteredData.count
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie: [String: Any]
        if isSearching {
            movie = filteredData[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        //let placeholderURL = URL(string: "https://httpbin.org/image/png")!
        //let placeholderImg = UIImage(named: "placeholder")
        //cell.moviePosterImage.af_setImage(withURL: placeholderURL, placeholderImage: placeholderImg)
        /*
         let url = URL(string: "https://httpbin.org/image/png")!
         let placeholderImage = UIImage(named: "placeholder")!
         
         let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
         size: imageView.frame.size,
         radius: 20.0
         )
         
         imageView.af_setImage(
         withURL: url,
         placeholderImage: placeholderImage,
         filter: filter,
         imageTransition: .crossDissolve(0.2)
         )
        */
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        
        cell.moviePosterImage.af_setImage(withURL: posterURL)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
