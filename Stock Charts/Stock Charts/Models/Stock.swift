//
//  Stock.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 17/12/21.
//


import Foundation

enum StockType : String {
    case percent
    case value 
    
}
struct QuoteResponse : Codable {
    let quoteResponse : StockResult
}

struct StockResult : Codable {
    let result:[Stock]
}
struct Stock : Codable {
    
    let regularMarketPrice: Double
    let regularMarketChange: Double
    let regularMarketChangePercent: Double
    let symbol: String
    let shortName: String
}

extension Stock {
    
    static var all : Resource<[Stock]> = {
        guard let url = URL(string: "https://yh-finance.p.rapidapi.com/market/v2/get-quotes?region=US&symbols=AMD%2CIBM%2CAAPL") else {
            fatalError("URL is incorrect")
            
        }
        let resource = Resource<[Stock]>(url: url)
        
        return resource
    }()
}
