//
//  MovieDB.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation
import Moya

public enum MovieDB {
    case details(id: Int)
    case search(query: String)
}

extension MovieDB: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .details(let id):
            return "/movie/\(id)"
        case .search(_):
            return "/search/movie"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .details(_), .search(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .details(let id):
            return .requestParameters(parameters: ["api_key": NetworkManager.apiKey, "movie_id": id], encoding: URLEncoding.default)
        case .search(let query):
            return .requestParameters(parameters: ["api_key": NetworkManager.apiKey, "query": query], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
      return .successCodes
    }
}
