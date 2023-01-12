//
//  Movie.swift
//  MovieVIPERPattern
//
//  Created by cihan on 20.12.22.
//

import Foundation
class Movie:Codable{
    
    var Title:String?
    var Year:String?
    var imdbID:String?
    var `Type`:String?
    var Poster:String?
    
   
    init(Title: String? = nil, Year: String? = nil, imdbID: String? = nil, Poster: String? = nil) {
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Poster = Poster
    }
    
    
}
