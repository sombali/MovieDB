//
//  Session.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

struct Session {
    let success: Bool
    let sessionId: String
}

extension Session: Decodable {
    enum SessionCodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SessionCodingKeys.self)
        
        success = try container.decode(Bool.self, forKey: .success)
        sessionId = try container.decode(String.self, forKey: .sessionId)
    }
}
