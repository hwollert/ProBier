//
//  BeerAPI.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

struct BeerRequest {
    func getAllBeer() async throws {
        guard let url = Punk.random() else { fatalError("Missing URL") }
                let urlRequest = URLRequest(url: url)
                let (data, response) = try await URLSession.shared.data(for: urlRequest)

                guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
                let decodedBeer = try JSONDecoder().decode([BeerEntity].self, from: data)
            print("Async decodedFood", decodedBeer)
    }
}
