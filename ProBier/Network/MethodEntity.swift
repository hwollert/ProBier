//
//  Method.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

struct MashTempEntity: Decodable {
    var temp: VolumeEntity?
    var duration: Int?
}

struct FermentationEntity: Decodable {
    var temp: VolumeEntity
}

struct MethodEntity: Decodable {
    var mash_temp: [MashTempEntity]
    var fermentation: FermentationEntity
    var twist: String?
}
