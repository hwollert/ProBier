//
//  BeerEntity.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

struct BeerEntity: Decodable {
    var id: Int
    var name: String
    var tagline: String
    var first_brewed: String
    var description: String
    var image_url: String?
    var abv: Double?
    var ibu: Double?
    var taget_fg: Double?
    var target_og: Double?
    var ebc: Double?
    var srm: Double?
    var ph: Double?
    var attenuataion_level: Double?
    var volume: Volume
    var boil_volume: Volume
    var method: Method
    var ingredients: Ingredients
    var food_pairing: [String]
    var brewers_tips: String
    var contributed_by: String
}
