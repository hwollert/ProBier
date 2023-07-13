//
//  BeerPreview.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerPreview: View {
    var body: some View {
        HStack {
            Image(systemName: "bubbles.and.sparkles")
                .frame(width: 80, height: 80)
                .background(.gray)
                .cornerRadius(8.0)
            VStack {
                HStack {
                    Text("Name")
                        .font(.title)
                    Spacer()
                }
                HStack {
                    Text("Tagline")
                        .font(.subheadline)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct BeerPreview_Previews: PreviewProvider {
    static var previews: some View {
        BeerPreview()
    }
}
