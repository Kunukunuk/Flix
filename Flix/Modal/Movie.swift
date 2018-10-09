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
    var backdropURL: URL?
    var releaseDate: String
    var id: String
    
    init(dictionary: [String: Any]) {
        print("dictiuonary: \(dictionary)")
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        let posterPath = dictionary["poster_path"] as! String
        posterUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        let backdropPath = dictionary["backdrop_path"] as! String
        backdropURL = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath)
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        id = dictionary["id"] as? String ?? "No id"
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
