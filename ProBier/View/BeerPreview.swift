//
//  BeerPreview.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerPreview: View {
    @State private var animationAmount = 0.0
    
    var beer: BeerModel
    
    var body: some View {
        HStack {
            BeerImage(beer: beer)
            VStack {
                HStack {
                    Text(beer.name)
                        .foregroundStyle(Color("TextColor"))
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Text(beer.tagline)
                        .foregroundStyle(Color("TextColor"))
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
        //        BeerPreview(beer: .constant(Beer()))
        Text("Hello World")
    }
}
