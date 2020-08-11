//
//  GuestSession.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

struct GuestSession {
    let success: Bool
    let guestSessionId: String?
    let expiresAt: String?
}

extension GuestSession: Decodable {
    enum GuestSessionCodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
        case expiresAt = "expires_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GuestSessionCodingKeys.self)
        
        success = try container.decode(Bool.self, forKey: .success)
        guestSessionId = try container.decodeIfPresent(String.self, forKey: .guestSessionId)
        expiresAt = try container.decodeIfPresent(String.self, forKey: .expiresAt)
    }
}
