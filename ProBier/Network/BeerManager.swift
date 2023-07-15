//
//  BeerAPI.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

final class BeerManager {
    static let shared: BeerManager = .init()
    
    private init() {}
    
}
 
extension BeerManager: BeerRepository {
    func getAllBeer(pageNumber: Int) async throws -> [BeerModel] {
        guard let url = Punk.getPage(number: pageNumber) else {
            throw ErrorType.notAvailable
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode == 200 else {
            if statusCode == 426 {
                throw ErrorType.tooManyRequests
            } else {
                throw ErrorType.notAvailable
            }
        }
        let decodedBeer = try JSONDecoder().decode([BeerEntity].self, from: data)
        return decodedBeer.map { BeerMapper.mapToModel(from: $0) }
    }
    
    func getBeerWithName(name: String) async throws -> [BeerModel] {
        guard let url = Punk.getBeerByName(name: name) else {
            throw ErrorType.notAvailable
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode == 200 else {
            if statusCode == 426 {
                throw ErrorType.tooManyRequests
            } else {
                throw ErrorType.notAvailable
            }
        }
        let decodedBeer = try JSONDecoder().decode([BeerEntity].self, from: data)
        return decodedBeer.map { BeerMapper.mapToModel(from: $0) }
    }
    
    func getRandomBeer() async throws -> BeerModel {
        guard let url = Punk.random() else {
            throw ErrorType.notAvailable
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode == 200 else {
            if statusCode == 426 {
                throw ErrorType.tooManyRequests
            } else {
                throw ErrorType.notAvailable
            }
        }
        let decodedBeer = try JSONDecoder().decode(BeerEntity.self, from: data)
        return BeerMapper.mapToModel(from: decodedBeer)
    }
}
