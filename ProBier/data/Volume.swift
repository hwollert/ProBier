//
//  Volume.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

enum Kind: String, Codable {
    case liters
    case celsius
    case kilograms
    case grams
}

struct Volume: Decodable {
    var value: Double?
    var unit: String?
}
