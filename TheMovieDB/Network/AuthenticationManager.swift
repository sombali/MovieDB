//
//  AuthenticationManager.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation
import Moya

struct AuthenticationManager {
    static var provider: MoyaProvider<MovieDBAuth> = MoyaProvider<MovieDBAuth>()
    
    static var requestToken: String = ""
    static let defaults = UserDefaults.standard
    
    static func getNewRequestToken(completion: @escaping (Authentication) -> (Void)) {
        provider.request(.newRequestToken) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(Authentication.self)
                        AuthenticationManager.requestToken = result.requestToken
                    completion(result)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSession() {
        provider.request(.newSessionId(requestToken: requestToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(Session.self)
                    self.defaults.set(result.sessionId, forKey: "sessionId")
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getGuestSession(completion: @escaping (GuestSession) -> (Void)) {
        provider.request(.newGuestSessionId) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try response.map(GuestSession.self)
                    self.defaults.set(result.guestSessionId, forKey: "guestSessionId")
                    completion(result)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
