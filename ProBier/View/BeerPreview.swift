//
//  BeerPreview.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerPreview: View {
    @State private var animationAmount = 0.0
    
    var beer: BeerEntity
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: beer.image_url ?? "https://images.punkapi.com/v2/227.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .animation(.easeInOut(duration: 1.0), value: animationAmount)
                    .opacity(animationAmount)
                    .padding(3)
            } placeholder: {
                Image(systemName: "bubbles.and.sparkles")
                    .font(.system(size: 40))
                    .opacity(animationAmount + 0.3)
                    .animation(
                        .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: animationAmount
                    )
            }
                .frame(width: 80, height: 80)
                .background(Color("LightGrayColor"))
                .cornerRadius(8.0)
                .padding(.trailing, 8)
            VStack {
                HStack {
                    Text(beer.name)
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Text(beer.tagline)
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
        .onAppear {
            animationAmount = 1.0
        }
    }
}

struct BeerPreview_Previews: PreviewProvider {
    static var previews: some View {
        BeerPreview(beer: BeerEntity(id: 1, name: "Ganther", tagline: "Beer from Freiburg", first_brewed: "1892", description: "Beer that is brewed in the city Freiburg", volume: VolumeEntity(), boil_volume: VolumeEntity(), method: MethodEntity(mash_temp: [], fermentation: FermentationEntity(temp: VolumeEntity()), twist: ""), ingredients: IngredientsEntity(malt: [], hops: []), food_pairing: [], brewers_tips: "", contributed_by: ""))
    }
}
