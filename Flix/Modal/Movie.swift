//
//  Movie.swift
//  Flix
//
//  Created by Kun Huang on 10/8/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        let posterPath = dictionary["poster_path"] as! String
        posterUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
