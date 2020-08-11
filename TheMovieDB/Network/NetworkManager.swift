//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation
import Moya

struct NetworkManager: Networkable {
    
    //TODO: insert api key here
    static let apiKey = "YOUR_API_KEY_HERE"
    
    static var provider: MoyaProvider<MovieDB> = MoyaProvider<MovieDB>()
    
    static func getMovieDetails(movieId: Int, completion: @escaping (Movie) -> (Void)) {
        provider.request(.details(id: movieId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(Movie.self)
                    completion(result)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSearchedMovies(queryString: String, completion: @escaping ([Movie]) -> (Void)) {
        
        provider.request(.search(query: queryString)) { (result) in
            switch result {
            case .success(let response):
              do {
                let results = try response.map(MovieResults<Movie>.self).results
                completion(results)
              } catch let error {
                print(error)
              }
            case .failure(let error):
                print(error)
            }
        }
    
    }
}
