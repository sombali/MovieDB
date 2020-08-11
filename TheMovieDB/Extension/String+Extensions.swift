//
//  Int+Extensions.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 03. 01..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import Foundation

extension String {
    static func currency(from price: Int) -> String {
        if price == 0 {
            return "The budget is unknown"
        }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.groupingSeparator = " "
        currencyFormatter.groupingSize = 3
        currencyFormatter.currencyCode = "USD"
        currencyFormatter.currencySymbol = "$"
    
        return currencyFormatter.string(from: NSNumber(value: price))!
    }
}
