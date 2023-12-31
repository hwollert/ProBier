//
//  BeerDetail.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel = BeerDetailViewModel()
    
    @FetchRequest(sortDescriptors: [],
                  animation: .none)
    private var items: FetchedResults<Beer>
    
    @State private var animationAmount = 1.0
    var beer: BeerModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    AsyncImage(url: URL(string: beer.image_url ?? "")) { image in
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
                        Text(beer.tagline)
                            .font(.largeTitle)
                        Text(beer.first_brewed)
                            .font(.subheadline)
                    }
                    Spacer()
                }
                HStack {
                    Text(beer.description)
                        .font(.body)
                    Spacer()
                }
                .padding(.vertical)
                
                Grid(alignment: .topLeading) {
                    GridRow(alignment: .top) {
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
                                    }
                                    .transition(.slide)
                                    Spacer()
                                }
                            }
                        }
                    }
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                    GridRow(alignment: .top) {
                        Text("Food Pairs: ")
                            .font(.callout)
                        VStack {
                            ForEach(beer.food_pairing, id: \.self) { food in
                                HStack {
                                    Text(food)
                                        .font(.body)
                                        .transition(.slide)
                                        .padding(.bottom, 3)
                                    Spacer()
                                }
                            }
                        }
                    }
                    Divider()
                    GridRow(alignment: .top) {
                        Text("Tipps: ")
                            .font(.callout)
                        HStack {
                            Text(beer.brewers_tips)
                                .font(.body)
                            Spacer()
                        }
                    }
                    Divider()
                    GridRow(alignment: .top) {
                        Text("Volume: ")
                            .font(.callout)
                        HStack {
                            Text(String(format: "%.1f \(beer.volume.unit ?? "liters")", beer.volume.value ?? 0.0))
                                .font(.body)
                            Spacer()
                        }
                    }
                    GridRow(alignment: .top) {
                        Text("Boil: ")
                            .font(.callout)
                        HStack {
                            Text(String(format: "%.1f \(beer.boil_volume.unit ?? "liters")", beer.boil_volume.value ?? 0.0))
                                .font(.body)
                            Spacer()
                        }
                    }
                }
                .padding(.top)
            }
            
            if viewModel.isBeerStored(beer: beer, items: items) {
                Button(action: {
                    withAnimation {
                        viewModel.deleteBeer(beer: beer, items: items, context: viewContext)
                    }
                }, label: {
                    Label("Delete Item", systemImage: "minus")
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .transition(.scale)
            } else {
                Button(action: {
                    withAnimation {
                        viewModel.storeBeer(beer: beer, context: viewContext)
                    }
                }, label: {
                    Label("Add Item", systemImage: "plus")
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .transition(.scale)
            }
        }
        .padding()
        .onAppear {
            animationAmount = 1.5
        }
        .navigationTitle(Text(beer.name))
    }
}

struct BeerDetail_Previews: PreviewProvider {
    static var previews: some View {
        //        BeerDetail(beer: BeerEntity(id: 1, name: "Ganther", tagline: "Beer from Freiburg", first_brewed: "1892", description: "Beer that is brewed in the city Freiburg", volume: VolumeEntity(), boil_volume: VolumeEntity(), method: MethodEntity(mash_temp: [], fermentation: FermentationEntity(temp: VolumeEntity()), twist: ""), ingredients: IngredientsEntity(malt: [IngredientEntity(name: "Malz", amount: VolumeEntity(value: 40.0, unit: "kilograms"), add: "start", attribute: "bitter")], hops: [IngredientEntity(name: "Hopfen", amount: VolumeEntity(value: 40.0, unit: "kilograms"), add: "start", attribute: "bitter")]), food_pairing: [], brewers_tips: "", contributed_by: ""))
        Text("Hello World")
    }
}
