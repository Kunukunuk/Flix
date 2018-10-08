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
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
    }
}
