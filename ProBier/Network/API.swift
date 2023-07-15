//
//  API.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

protocol API {
    static var baseUrl: URL? { get }
}


enum Punk: API {
    static var baseUrl = URL(string: "https://api.punkapi.com/v2/beers")
    
    static func random() -> URL? {
        baseUrl?.appendingPathComponent("random")
    }
    
    static func getPage(number: Int) -> URL? {
        let page = URLQueryItem(name: "page", value: "\(number)")
        let perPage = URLQueryItem(name: "per_page", value: "10")
        return baseUrl?.appending(queryItems: [page, perPage])
    }
    
    static func getBeerByName(name: String) -> URL? {
        let beerName = URLQueryItem(name: "beer_name", value: name)
        return baseUrl?.appending(queryItems: [beerName])
    }
}
