//
//  BeerList.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerList: View {
    @StateObject private var viewModel = BeerListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.beers, id: \.id) { beer in
                        NavigationLink(destination: {
                            BeerDetail(beer: beer)
                        }) {
                            BeerPreview(beer: beer)
                                .transition(.opacity)
                                .onAppear {
                                    viewModel.laodNewPage(index: beer.id)
                                }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.update()
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList()
    }
}
