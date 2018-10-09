//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Kun Huang on 9/11/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [[String: Any]] = []
    var genreID = 28
    var genreName = "Superhero"
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        movies = []
        self.navigationItem.title = "\(genreName) Movies"
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        fetchMovies(search: isSearching)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        if let posterPath = movie["poster_path"] as? String {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURL + posterPath)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    func fetchMovies(search: Bool) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                //self.alert()
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                if search {
                    for movie in movies {
                        let genre = movie["genre_ids"]! as! NSArray
                        if genre.contains(self.genreID) {
                            self.movies.append(movie)
                        }
                    
                    }
                } else {
                    self.movies = movies
                }
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
               // self.activity.stopAnimating()
                //self.filteredData = self.movies
                
            }
        }
        task.resume()
    }
    
    @IBAction func getlAllMovies(_ sender: UIBarButtonItem) {
        isSearching = false
        fetchMovies(search: isSearching)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "GoToDetails") {
            let cell = sender as! UICollectionViewCell
            if let indexPath = collectionView.indexPath(for: cell) {
                let movie = movies[indexPath.row]
                let detailViewController = segue.destination as! DetailsViewController
                //detailViewController.movie = movie
            }
        } else if (segue.identifier == "FromSuper") {
            let search = segue.destination as! GenrePickerViewController
            search.from = true
        }
        
    }
    
}

