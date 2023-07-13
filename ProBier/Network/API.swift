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
        baseUrl?.appendingPathComponent("?page=\(number)&per_page=10")
    }
    
    static func getBeerByName(name: String) -> URL? {
        baseUrl?.appendingPathComponent("?beer_name=\(name)")
    }
}
