//
//  ProBierApp.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

@main
struct ProBierApp: App {
    let persistenceController = PersistenceController.shared
    
    @State private var isShowingDetailView = false
    @State private var randomBeer: BeerModel?
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .navigationDestination(isPresented: $isShowingDetailView) {
                        if randomBeer != nil {
                            BeerDetail(beer: randomBeer!)
                        }
                    }
            }
            .onOpenURL(perform: { url in
                Task {
                    do {
                        randomBeer = try await BeerManager.shared.getBeerWithId(id: url.host ?? "")[0]
                        isShowingDetailView.toggle()
                    } catch ErrorType.tooManyRequests {
                        print("too many requests")
                    } catch ErrorType.notAvailable {
                        print("not available")
                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            })
        }
    }
}
