//
//  Movie.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let budget: Int?
    let posterPath: String?
    let overview: String
    let releaseDate: String
}

extension Movie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case title
        case budget
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        budget = try container.decodeIfPresent(Int.self, forKey: .budget)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        overview = try (container.decodeIfPresent(String.self, forKey: .overview) ?? "")
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}

extension Movie: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
