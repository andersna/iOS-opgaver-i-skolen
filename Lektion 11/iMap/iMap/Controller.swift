//
//  Controller.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import Foundation
import MapKit

@Observable
class Controller: Identifiable {
    let url = URL(string: "https://randomuser.me/api/?results=30&nat=dk")!
    var randomUsers: [RandomUser] = []
    var imageCache: [UUID: UIImage] = [:]
    
    @MainActor
    func createRandomUsers() async {
        do {
            let userData = try await Network.fetchData(from: url)
            let user = try JSONDecoder().decode(RandomUserResults.self, from: userData)
            randomUsers.append(contentsOf: user.results)
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    func getDirections(from: UUID, to: UUID) async -> MKRoute? {
        let users = randomUsers
        
        guard let source = users.first(where: { $0.id == from }),
              let destination = users.first(where: { $0.id == to }),
              let sourceCoord = source.clCoordinate,
              let destCoord = destination.clCoordinate else {
            return nil
        }
        
        let sourceMK = MKMapItem(location: sourceCoord, address: nil)
        let destinationMK = MKMapItem(location: destCoord, address: nil)
        
        let request = MKDirections.Request()
        request.transportType = .any
        request.source = sourceMK
        request.destination = destinationMK
        
        do {
            let directions = MKDirections(request: request)
            let response = try await directions.calculate()
            return response.routes.first
        } catch {
            print("Error calculating directions: \(error)")
            return nil
        }
    }
    
    func fetchImage(for user: RandomUser) async -> UIImage? {
        // Tjek cache først
        if let cached = imageCache[user.id] {
            return cached
        }
        
        // Hent nyt billede
        guard let image = await user.fetchImage() else {
            return nil
        }
        
        // Gem i cache
        imageCache[user.id] = image
        
        return image
    }
}
