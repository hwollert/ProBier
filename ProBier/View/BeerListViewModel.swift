//
//  BeerListViewModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

@MainActor class BeerListViewModel: ObservableObject {
    @Published var beers: [BeerEntity] = []
    
    private var page: Int = 1
    
    func update() {
        Task {
            do {
                let result = try await BeerRequest().getAllBeer(pageNumber: page)
                beers.append(contentsOf: result)
            } catch let error {
                print("await error \(error)")
            }
        }
    }
    
    func laodNewPage(index: Int) {
        if index % 10 == 0 && index == beers.count {
            page += 1
            update()
        }
    }
}
