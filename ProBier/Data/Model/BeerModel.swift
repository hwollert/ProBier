//
//  BeerModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

struct BeerModel: Decodable {
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
    var volume: VolumeModel
    var boil_volume: VolumeModel
    var method: MethodModel
    var ingredients: IngredientsModel
    var food_pairing: [String]
    var brewers_tips: String
    var contributed_by: String
}
