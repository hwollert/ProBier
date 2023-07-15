//
//  BeerRepository.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 14.07.23.
//

protocol BeerRepository {
    func getAllBeer(pageNumber: Int) async throws -> [BeerModel]
    func getBeerWithName(name: String) async throws -> [BeerModel]
    func getRandomBeer() async throws -> BeerModel
}
