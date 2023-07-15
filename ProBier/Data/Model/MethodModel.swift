//
//  MethodModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

struct MashTempModel: Decodable {
    var temp: VolumeModel?
    var duration: Int?
}

struct FermentationModel: Decodable {
    var temp: VolumeModel
}

struct MethodModel: Decodable {
    var mash_temp: [MashTempModel]
    var fermentation: FermentationModel
    var twist: String?
}
