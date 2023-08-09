//
//  BeerImage.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 20.07.23.
//

import SwiftUI

struct BeerImage: View {
    @State private var animationAmount = 0.0
    
    var beer: BeerModel
    
    var body: some View {
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
    }
}

//#Preview {
//    BeerImage()
//}
