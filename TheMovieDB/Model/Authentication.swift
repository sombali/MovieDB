//
//  Authentication.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

struct Authentication {
    let success: Bool
    let expiresAt: String?
    let requestToken: String
}

extension Authentication: Decodable {
    enum AuthenticationKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AuthenticationKeys.self)
        
        success = try container.decode(Bool.self, forKey: .success)
        expiresAt = try container.decodeIfPresent(String.self, forKey: .expiresAt)
        requestToken = try container.decode(String.self, forKey: .requestToken)
    }
}
