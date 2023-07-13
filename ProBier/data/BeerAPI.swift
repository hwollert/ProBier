//
//  BeerAPI.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import Foundation

struct BeerAPI {
    func getAllBeer() async throws {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/random") else { fatalError("Missing URL") }
                let urlRequest = URLRequest(url: url)
                let (data, response) = try await URLSession.shared.data(for: urlRequest)

                guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
                let decodedBeer = try JSONDecoder().decode([BeerEntity].self, from: data)
            print("Async decodedFood", decodedBeer)
    }
}
