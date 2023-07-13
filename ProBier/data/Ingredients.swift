//
//  Ingredients.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

struct Ingredient: Decodable {
    var name: String
    var amount: Volume
    var add: String?
    var attribute: String?
}

struct Ingredients: Decodable {
    var malt: [Ingredient]
    var hops: [Ingredient]
    var yeast: String?
}
