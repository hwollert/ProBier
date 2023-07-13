//
//  Ingredients.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

struct IngredientEntity: Decodable {
    var name: String
    var amount: VolumeEntity
    var add: String?
    var attribute: String?
}

struct IngredientsEntity: Decodable {
    var malt: [IngredientEntity]
    var hops: [IngredientEntity]
    var yeast: String?
}
