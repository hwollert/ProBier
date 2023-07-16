//
//  IngredientsModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

struct IngredientModel: Decodable {
    var name: String
    var amount: VolumeModel
    var add: String?
    var attribute: String?
}

struct IngredientsModel: Decodable {
    var malt: [IngredientModel]
    var hops: [IngredientModel]
    var yeast: String?
}
