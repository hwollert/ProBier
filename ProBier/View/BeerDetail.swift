//
//  BeerDetail.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerDetail: View {
    @State private var animationAmount = 1.0
    
    var beer: BeerEntity
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: beer.image_url ?? "https://images.punkapi.com/v2/227.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                } placeholder: {
                    Image(systemName: "bubbles.and.sparkles")
                        .font(.system(size: 50))
                        .opacity(1.75 - animationAmount)
                        .animation(
                            .easeInOut(duration: 2)
                                .repeatForever(autoreverses: true),
                            value: animationAmount
                        )
                }
                    .frame(width: 120, height: 120)
                    .background(Color("LightGrayColor"))
                    .cornerRadius(8.0)
                    .padding(.trailing, 8)
                VStack {
                    Text(beer.name)
                        .font(.largeTitle)
                    Text(beer.first_brewed)
                        .font(.subheadline)
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(beer.tagline)
                        .font(.headline)
                    Text(beer.description)
                        .font(.body)
                }
                Spacer()
            }
            .padding(.vertical)
            
            HStack(alignment: .top) {
                Text("Ingredients: ")
                    .font(.callout)
                VStack {
                    ForEach(beer.ingredients.malt + beer.ingredients.hops, id: \.name) { ingredient in
                        HStack {
                            HStack {
                                Text(ingredient.name)
                                    .font(.body)
                                Text(String(format: "%.1f \(ingredient.amount.unit ?? "")", ingredient.amount.value ?? 0))
                                    .font(.caption)
//                                Text("\(ingredient.add ?? "")")
//                                    .font(.caption)
//                                Text("\(ingredient.attribute ?? "")")
//                                    .font(.caption)
                            }
                            .transition(.slide)
                            Spacer()
                        }
                    }
                }
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Food Pairs: ")
                        .font(.callout)
                    VStack {
                        ForEach(beer.food_pairing, id: \.self) { food in
                            HStack {
                                Text(food)
                                    .font(.body)
                                    .transition(.slide)
                                Spacer()
                            }
                        }
                    }
                }
                HStack(alignment: .top) {
                    Text("Tipps: ")
                        .font(.callout)
                    Text(beer.brewers_tips)
                        .font(.body)
                }
                .padding(.top)
                
                HStack(alignment: .top) {
                    Text("Volume: ")
                        .font(.callout)
                    Text(String(format: "%.1f \(beer.volume.unit ?? "liters")", beer.volume.value ?? 0.0))
                        .font(.body)
                }
                .padding(.top)
                
                HStack(alignment: .top) {
                    Text("Boil: ")
                        .font(.callout)
                    Text(String(format: "%.1f \(beer.boil_volume.unit ?? "liters")", beer.boil_volume.value ?? 0.0))
                        .font(.body)
                    Spacer()
                }
                .padding(.top)
                
                Spacer()
            }
        }
        .padding()
        .onAppear {
            animationAmount = 1.5
        }
    }
}

struct BeerDetail_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetail(beer: BeerEntity(id: 1, name: "Ganther", tagline: "Beer from Freiburg", first_brewed: "1892", description: "Beer that is brewed in the city Freiburg", volume: VolumeEntity(), boil_volume: VolumeEntity(), method: MethodEntity(mash_temp: [], fermentation: FermentationEntity(temp: VolumeEntity()), twist: ""), ingredients: IngredientsEntity(malt: [IngredientEntity(name: "Malz", amount: VolumeEntity(value: 40.0, unit: "kilograms"), add: "start", attribute: "bitter")], hops: [IngredientEntity(name: "Hopfen", amount: VolumeEntity(value: 40.0, unit: "kilograms"), add: "start", attribute: "bitter")]), food_pairing: [], brewers_tips: "", contributed_by: ""))
    }
}
