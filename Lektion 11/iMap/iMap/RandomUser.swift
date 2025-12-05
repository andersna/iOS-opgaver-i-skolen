//
//  RandomUser.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import SwiftUI
import Foundation
import CoreLocation

struct RandomUserResults: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable, Identifiable{
    
    var id = UUID()
    let name: Name
    let location: Location
    let picture: Picture
    
    private enum CodingKeys: String, CodingKey {
        case name, location, picture
    }
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    struct Location: Codable {
        let city: String
        let country: String
        let coordinates: Coordinates
        
        struct Coordinates: Codable {
            let latitude: String
            let longitude: String
        }
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    func fetchImage() async -> UIImage?{
        guard let url = URL(string: picture.thumbnail) else {
            return nil
        }
        do {
            let data = try! await Network.fetchData(from: url)
            return UIImage(data: data)
        }
    }
    
    var clCoordinate: CLLocation?{
        if let lat = Double(location.coordinates.latitude),
           let lon = Double(location.coordinates.longitude) {
            return CLLocation(latitude: lat, longitude: lon)
        }
        return nil
    }
    
    var coordinate: CLLocationCoordinate2D? {
        if let lat = Double(location.coordinates.latitude),
           let lon = Double(location.coordinates.longitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        return nil
    }
    
    static let dummyUser = RandomUser(
        name: .init(title: "Mr", first: "John", last: "Doe"),
        location: .init(
            city: "Copenhagen",
            country: "Denmark",
            coordinates: .init(latitude: "55.6761", longitude: "12.5683")
        ),
        picture: .init(
            large: "https://randomuser.me/api/portraits/men/1.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/1.jpg"
        )
    )
}
