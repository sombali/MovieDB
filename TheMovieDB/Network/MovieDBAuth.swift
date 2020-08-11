//
//  Authentication.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation
import Moya

public enum MovieDBAuth {
    case newRequestToken
    case newSessionId(requestToken: String)
    case newGuestSessionId
}

extension MovieDBAuth: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/authentication")!
    }
    
    public var path: String {
        switch self {
        case .newRequestToken:
            return "/token/new"
        case .newSessionId(_):
            return "/session/new"
        case .newGuestSessionId:
            return "/guest_session/new"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .newRequestToken, .newGuestSessionId:
            return .get
        case .newSessionId(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .newRequestToken, .newGuestSessionId:
            return .requestParameters(parameters: ["api_key": NetworkManager.apiKey], encoding: URLEncoding.default)
        case .newSessionId(let requestToken):
            return .requestParameters(parameters: ["request_token": requestToken, "api_key": NetworkManager.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
