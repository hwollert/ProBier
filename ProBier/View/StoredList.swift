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
                }) {
                    BeerPreview(beer: BeerMapper.mapToModel(from: beer))
                        .transition(.opacity)
                }
            }
            .navigationTitle("Beer Store")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { storedBeers[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct StoredList_Previews: PreviewProvider {
    static var previews: some View {
        StoredList()
    }
}
