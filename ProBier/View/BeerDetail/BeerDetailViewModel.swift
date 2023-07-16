//
//  BeerDetailViewModel.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 16.07.23.
//

import CoreData
import Foundation
import SwiftUI

@MainActor class BeerDetailViewModel: ObservableObject {

    func storeBeer(beer: BeerModel, context: NSManagedObjectContext) {
        _ = ModelMapper.mapToBeer(from: beer, context: context)
        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func deleteBeer(beer: BeerModel, items: FetchedResults<Beer>, context: NSManagedObjectContext) {
        items.filter { $0.name == beer.name }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func isBeerStored(beer: BeerModel, items: FetchedResults<Beer>) -> Bool {
        items.contains(where: {
            $0.id == beer.id
        })
    }
}
