//
//  BeerList.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerList: View {
    @Environment(\.isSearching) private var isSearching
    
    @StateObject private var viewModel = BeerListViewModel()
    @State private var searchText = ""
    
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
                                    viewModel.laodNewPage(index: Int(beer.id))
                                }
                        }
                    }
                }
            }
            .navigationTitle("Beer everywhere")
            .refreshable {
                viewModel.update(renew: true)
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Look for something")
        .onSubmit(of: .search, startSearch)
        .onAppear {
            viewModel.update()
        }
        .alert("Error", isPresented: $viewModel.errorThrown, actions: {})
        .onChange(of: searchText) { value in
            if searchText.isEmpty && !isSearching {
                viewModel.cancelSearch()
            }
        }
    }
    
    func startSearch() {
        viewModel.search(text: searchText)
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList()
    }
}
