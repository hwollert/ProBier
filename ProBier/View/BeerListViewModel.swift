//
//  BeerListViewModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

@MainActor class BeerListViewModel: ObservableObject {
    @Published var beers: [BeerEntity] = []
    
    func update() {
        Task {
            do {
                beers = try await BeerRequest().getAllBeer()
            } catch let error {
                print("await error \(error)")
            }
        }
    }
}
