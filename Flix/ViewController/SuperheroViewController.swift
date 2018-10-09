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
    var movies: [Movie] = []
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
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    func fetchMovies(search: Bool) {
        
        MovieApiManager().nowPlayingGenreMovies(search: search, genreId: genreID) { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
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
                detailViewController.movie = movie
            }
        } else if (segue.identifier == "FromSuper") {
            let search = segue.destination as! GenrePickerViewController
            search.from = true
        }
        
    }
    
}

