//
//  BeerList.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

struct BeerList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.isSearching) private var isSearching
    
    @StateObject private var viewModel = BeerListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.beers.isEmpty {
                    Text("No beers loaded yet")
                } else {
                    VStack {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.beers, id: \.id) { beer in
                                    NavigationLink(destination: {
                                        BeerDetail(beer: beer)
                                            .environment(\.managedObjectContext, viewContext)
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
                }
                if viewModel.loading == .loading {
                    ProgressView()
                }
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
