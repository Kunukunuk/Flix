//
//  MovieApiManager.swift
//  Flix
//
//  Created by Kun Huang on 10/8/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation

class MovieApiManager {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        
        let url = URL(string: MovieApiManager.baseUrl + "now_playing?api_key=\(MovieApiManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func nowPlayingGenreMovies(search: Bool, genreId: Int, completion: @escaping ([Movie]?, Error?) -> ()) {
        
        let url = URL(string: MovieApiManager.baseUrl + "now_playing?api_key=\(MovieApiManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                var movieArray: [[String: Any]] = []
                if search {
                    for movie in movieDictionaries {
                        let genre = movie["genre_ids"]! as! NSArray
                        if genre.contains(genreId) {
                            movieArray.append(movie)
                        }
                        
                    }
                } else {
                    movieArray = movieDictionaries
                }
                let movies = Movie.movies(dictionaries: movieArray)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func topRatedMovies(search: Bool, genreId: Int, completion: @escaping ([Movie]?, Error?) -> ()) {
        
        let url = URL(string: MovieApiManager.baseUrl + "top_rated?api_key=\(MovieApiManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                var movieArray: [[String: Any]] = []
                
                if search {
                    for movie in movieDictionaries {
                        let genre = movie["genre_ids"]! as! NSArray
                        if genre.contains(genreId) {
                            movieArray.append(movie)
                        }
                        
                    }
                } else {
                    movieArray = movieDictionaries
                }
                let movies = Movie.movies(dictionaries: movieArray)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
}
