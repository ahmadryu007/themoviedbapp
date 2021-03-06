//
//  Constants.swift
//  The Movie DB App
//
//  Created by Ahmad Krisman Ryuzaki on 4/3/21.
//

import Foundation

class Constants {
    
    static let apiKey = "a3cd701cfc65f2e9863dc70fa8ea6d5e"
    static let url = "https://api.themoviedb.org"
    static let apiVersion = "3"
    static let baseUrl = Constants.url + "/" + apiVersion
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w200/"
    
    static let genreListPath = baseUrl + "/genre/movie/list"
    static let movieListPath = baseUrl + "/discover/movie"
    static let videoListPath = baseUrl + "/movie/"
    static let reviewListPath = baseUrl + "/movie/"
    
}
