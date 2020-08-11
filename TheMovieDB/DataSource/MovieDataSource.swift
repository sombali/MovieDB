//
//  MovieDataSource.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 03. 01..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

protocol MovieDataSourceDelegate: class {
    func dataSource(_ dataSource: MovieDataSource, didFinishFetching movies: [Movie])
}


class MovieDataSource {
    static let shared = MovieDataSource()
    weak var delegate: MovieDataSourceDelegate?
    
    var movies: [Movie] = []
    
    private init() {
        
    }
    
    func getDetailedMovies(for query: String) {
        self.movies = []
        
        NetworkManager.getSearchedMovies(queryString: query) { (movies) -> (Void) in
            movies.forEach { movie in
                NetworkManager.getMovieDetails(movieId: movie.id) { (detailedMovie) -> (Void) in
                    self.movies.append(detailedMovie)
                    
                    if self.movies.count == movies.count {
                        self.delegate?.dataSource(self, didFinishFetching: self.movies)
                    }
                }
            }
        }
    }
    
    func clearMovies() {
        self.movies = []
        self.delegate?.dataSource(self, didFinishFetching: movies)
    }
}
