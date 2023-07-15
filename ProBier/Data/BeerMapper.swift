//
//  BeerMapper.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

import Foundation

enum BeerMapper {
    static func mapToModel(from entity: BeerEntity) -> BeerModel {
        let method = MethodModel(
            mash_temp: entity.method.mash_temp.map {
                MashTempModel(
                    temp: VolumeModel(value: $0.temp?.value, unit: $0.temp?.unit),
                    duration: $0.duration
                )
            },
            fermentation:
                FermentationModel(
                    temp: VolumeModel(value: entity.method.fermentation.temp.value, unit: entity.method.fermentation.temp.unit)
                )
        )
        
        let ingredients = IngredientsModel(
            malt: entity.ingredients.malt.map {
                IngredientModel(
                    name: $0.name,
                    amount: VolumeModel(value: $0.amount.value, unit: $0.amount.unit),
                    add: $0.add,
                    attribute: $0.attribute
                )
            },
            hops: entity.ingredients.hops.map {
                IngredientModel(
                    name: $0.name,
                    amount: VolumeModel(value: $0.amount.value, unit: $0.amount.unit),
                    add: $0.add,
                    attribute: $0.attribute
                )
            },
            yeast: entity.ingredients.yeast)
        
        let newBeer = BeerModel(
            id: entity.id,
            name: entity.name,
            tagline: entity.tagline,
            first_brewed: entity.first_brewed,
            description: entity.description,
            image_url: entity.image_url,
            abv: entity.abv ?? 0,
            ebc: entity.ebc ?? 0,
            srm: entity.srm ?? 0,
            ph: entity.ph ?? 0,
            volume: VolumeModel(value: entity.volume.value, unit: entity.volume.unit),
            boil_volume: VolumeModel(value: entity.boil_volume.value, unit: entity.boil_volume.unit),
            method: method,
            ingredients: ingredients,
            food_pairing: entity.food_pairing,
            brewers_tips: entity.brewers_tips,
            contributed_by: entity.contributed_by
        )
        return newBeer
    }
    
    static func mapToModel(from entity: Beer) -> BeerModel {
        let ingredients = Array(entity.ingredients as! Set<Ingredient>)
        let ingredientModel = IngredientsModel(
            malt: ingredients.map { IngredientModel(
                name: $0.name ?? "",
                amount: VolumeModel(value: $0.amount?.value, unit: $0.amount?.unit),
                add: $0.add,
                attribute: $0.attribute
            )},
            hops: [])
        
        let newBeer = BeerModel(
            id: Int(entity.id),
            name: entity.name ?? "",
            tagline: entity.tagline ?? "",
            first_brewed: entity.first_brewed ?? "",
            description: entity.desc ?? "",
            image_url: entity.image_url,
            abv: entity.abv,
            ebc: entity.ebc,
            srm: entity.srm,
            ph: entity.ph,
            volume: VolumeModel(value: entity.volume?.value, unit: entity.volume?.unit),
            boil_volume: VolumeModel(value: entity.boil_volume?.value, unit: entity.boil_volume?.unit),
            ingredients: ingredientModel,
            food_pairing: Array(entity.food_pairing as? Set<String> ?? []),
            brewers_tips: entity.brewers_tips ?? "",
            contributed_by: entity.contributed_by ?? ""
        )
        return newBeer
    }
}
