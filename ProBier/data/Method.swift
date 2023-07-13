//
//  Method.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

struct Method: Decodable {
    var mash_temp: [MashTemp]
    var fermentation: Fermentation
    var twist: String?
}
