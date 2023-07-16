//
//  BeerListViewModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

@MainActor class BeerListViewModel: ObservableObject {
    @Published var beers: [BeerModel] = []
    @Published var errorThrown = false
    @Published var loading = StateType.idle
    
    private let interactor = BeerInteractor(repository: BeerManager.shared)
    private var page: Int = 1
    private var cachedBeers: [BeerModel] = []
    
    func update(renew: Bool = false) {
        Task {
            do {
                loading = StateType.loading
                if renew {
                    page = 1
                    beers.removeAll()
                }
                let result = try await interactor.getAllBeer(pageNumber: page)
                beers.append(contentsOf: result)
                loading = StateType.idle
            } catch ErrorType.tooManyRequests {
                errorThrown = true
            } catch ErrorType.notAvailable {
                errorThrown = true
            }
        }
    }
    
    func laodNewPage(index: Int) {
        if index % 10 == 0 && index == beers.count {
            page += 1
            update()
        }
    }
    
    func search(text: String) {
        Task {
            do {
                loading = StateType.loading
                cachedBeers = beers
                beers = try await interactor.getBeerWithName(name: text)
                loading = StateType.idle
            } catch let error {
                print("await error \(error)")
            }
        }
    }
    
    func cancelSearch() {
        if !cachedBeers.isEmpty {
            beers = cachedBeers
            cachedBeers.removeAll()
        }
    }
}
