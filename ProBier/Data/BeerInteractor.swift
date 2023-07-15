//
//  BeerInteractor.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

final class BeerInteractor {
    private var repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func getAllBeer(pageNumber: Int) async throws -> [BeerModel] {
        try await repository.getAllBeer(pageNumber: pageNumber)
    }
    
    func getBeerWithName(name: String) async throws -> [BeerModel] {
        try await repository.getBeerWithName(name: name)
    }
    
    func getRandomBeer() async throws -> BeerModel {
        try await repository.getRandomBeer()
    }
}
