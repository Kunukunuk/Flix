//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/5/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    //var movies: [[String: Any]] = []
    var allMovies: [Movie] = []
    var filteredData: [Movie] = []
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        activity.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
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
            filteredData = allMovies
            tableView.reloadData()
        } else {
            isSearching = true
            filteredData = allMovies.filter {
                 ($0.title).lowercased().contains(searchText.lowercased())
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
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.allMovies = movies
                self.filteredData = self.allMovies
                self.tableView.reloadData()
            }
            self.refreshControl.endRefreshing()
            self.activity.stopAnimating()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching) {
            return filteredData.count
        }
        return allMovies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = allMovies[indexPath.row]
            let detailViewController = segue.destination as! DetailsViewController
            detailViewController.movie = movie
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if isSearching {
            cell.movie = filteredData[indexPath.row]
        } else {
            cell.movie = allMovies[indexPath.row]
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
