//
//  ContentView.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedList = "All"
    private var lists = ["All", "Stored"]

    var body: some View {
            VStack {
                if selectedList == lists[0] {
                    BeerList()
                        .environment(\.managedObjectContext, viewContext)

                } else {
                    StoredList()
                        .environment(\.managedObjectContext, viewContext)
                }
                Picker("", selection: $selectedList) {
                    ForEach(lists, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
