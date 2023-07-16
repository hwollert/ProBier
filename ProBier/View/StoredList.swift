//
//  StoredList.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 15.07.23.
//

import SwiftUI

struct StoredList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Beer.id, ascending: true)],
        animation: .default)
    private var storedBeers: FetchedResults<Beer>
    
    var body: some View {
        NavigationView {
            List(storedBeers) { beer in
                NavigationLink(destination: {
                    BeerDetail(beer: BeerMapper.mapToModel(from: beer))
                        .environment(\.managedObjectContext, viewContext)
                }) {
                    BeerPreview(beer: BeerMapper.mapToModel(from: beer))
                        .transition(.opacity)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            .navigationTitle("Beer Store")
        }
    }
}

struct StoredList_Previews: PreviewProvider {
    static var previews: some View {
        StoredList()
    }
}
