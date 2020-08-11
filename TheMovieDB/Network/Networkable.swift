//
//  Networkable.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    static var provider: MoyaProvider<MovieDB> { get }
}
