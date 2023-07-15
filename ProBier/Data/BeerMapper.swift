//
//  BeerMapper.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

import Foundation
import CoreData

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
    
    static func mapToBeer(from entity: BeerEntity) -> Beer {
        let context = PersistenceController.shared.container.viewContext
        let newBeer = Beer(context: context)
        newBeer.id = Int16(entity.id)
        newBeer.name = entity.name
        newBeer.tagline = entity.tagline
        newBeer.desc = entity.description
        newBeer.image_url = entity.image_url
        newBeer.abv = entity.abv ?? 0
        newBeer.ebc = entity.ebc ?? 0
        newBeer.ph = entity.ph ?? 0
        newBeer.srm = entity.srm ?? 0
        newBeer.first_brewed = entity.first_brewed
        newBeer.brewers_tips = entity.brewers_tips
        
        var foods = Set<Food_Pair>()
        for food in entity.food_pairing {
            let newFood = Food_Pair(context: context)
            newFood.food = food
            foods.insert(newFood)
        }
        if !foods.isEmpty {
            newBeer.food_pairing = foods as NSSet
        }
        
        let newVolume = Volume(context: context)
        newVolume.value = entity.volume.value ?? 0
        newVolume.unit = entity.volume.unit
        
        let newBoilVolume = Volume(context: context)
        newBoilVolume.value = entity.boil_volume.value ?? 0
        newBoilVolume.unit = entity.boil_volume.unit
        
        newBeer.volume = newVolume
        newBeer.boil_volume = newBoilVolume
        
        for ingredient in entity.ingredients.malt + entity.ingredients.hops {
            let newIngredient = Ingredient(context: context)
            newIngredient.name = ingredient.name
            newIngredient.add = ingredient.add
            newIngredient.attribute = ingredient.attribute
            let amount = Volume(context: context)
            amount.value = ingredient.amount.value ?? 0
            amount.unit = ingredient.amount.unit
            
            newIngredient.amount = amount
            
            newBeer.ingredients?.adding(newIngredient)
        }
        
        return newBeer
    }
    
    static func mapToBeer(
        from entity: BeerModel,
        context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) -> Beer
    {
        let newBeer = Beer(context: context)
        newBeer.id = Int16(entity.id)
        newBeer.name = entity.name
        newBeer.tagline = entity.tagline
        newBeer.desc = entity.description
        newBeer.image_url = entity.image_url
        newBeer.abv = entity.abv ?? 0
        newBeer.ebc = entity.ebc ?? 0
        newBeer.ph = entity.ph ?? 0
        newBeer.srm = entity.srm ?? 0
        newBeer.first_brewed = entity.first_brewed
        newBeer.brewers_tips = entity.brewers_tips
        
        var foods = Set<Food_Pair>()
        for food in entity.food_pairing {
            let newFood = Food_Pair(context: context)
            newFood.food = food
            foods.insert(newFood)
        }
        if !foods.isEmpty {
            newBeer.food_pairing = foods as NSSet
        }
        
        let newVolume = Volume(context: context)
        newVolume.value = entity.volume.value ?? 0
        newVolume.unit = entity.volume.unit
        
        let newBoilVolume = Volume(context: context)
        newBoilVolume.value = entity.boil_volume.value ?? 0
        newBoilVolume.unit = entity.boil_volume.unit
        
        newBeer.volume = newVolume
        newBeer.boil_volume = newBoilVolume
        
        for ingredient in entity.ingredients.malt + entity.ingredients.hops {
            let newIngredient = Ingredient(context: context)
            newIngredient.name = ingredient.name
            newIngredient.add = ingredient.add
            newIngredient.attribute = ingredient.attribute
            let amount = Volume(context: context)
            amount.value = ingredient.amount.value ?? 0
            amount.unit = ingredient.amount.unit
            
            newIngredient.amount = amount
            
            newBeer.ingredients?.adding(newIngredient)
        }
        
        return newBeer
    }
}
