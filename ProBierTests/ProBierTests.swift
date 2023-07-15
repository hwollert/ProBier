//
//  ProBierTests.swift
//  ProBierTests
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import XCTest

final class ProBierTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRequest() throws {
        let requestPage = Punk.getPage(number: 1)
        XCTAssertEqual(requestPage, URL(string: "https://api.punkapi.com/v2/beers?page=1&per_page=10"))
        
        let requestName = Punk.getBeerByName(name: "Pilsen")
        XCTAssertEqual(requestName, URL(string: "https://api.punkapi.com/v2/beers?beer_name=Pilsen"))
        
        let requestRandom = Punk.random()
        XCTAssertEqual(requestRandom, URL(string: "https://api.punkapi.com/v2/beers/random"))
    }

    func testJSONValidData() throws {
        let url = Bundle(for: ProBierTests.self).url(forResource: "MockData", withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoded = try JSONDecoder().decode([BeerEntity].self, from: data)
        
        XCTAssertEqual(decoded[0].name, "Punk IPA 2007 - 2010")
        XCTAssertEqual(decoded[0].tagline, "Post Modern Classic. Spiky. Tropical. Hoppy.")
        XCTAssertEqual(decoded[0].image_url, "https://images.punkapi.com/v2/192.png")
        XCTAssertEqual(decoded[0].volume.value, 20)
        XCTAssertEqual(decoded[0].ingredients.malt[0].name, "Extra Pale")
        XCTAssertEqual(decoded[0].ingredients.malt[0].amount.unit, "kilograms")
        XCTAssertEqual(decoded[0].ingredients.hops[0].name, "Ahtanum")
        XCTAssertEqual(decoded[0].ingredients.hops[0].amount.unit, "grams")
        XCTAssertEqual(decoded[0].food_pairing[2], "Cheesecake with a passion fruit swirl sauce")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
