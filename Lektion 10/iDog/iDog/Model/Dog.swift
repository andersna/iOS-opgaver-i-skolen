//
//  Dog.swift
//  iDog
//
//  Created by dmu mac 29 on 24/09/2025.
//

import Foundation

struct Dog: Codable, Identifiable{
    let message: String
    let status: String
    
    var id: String {message}
    var url: URL {
        URL(string: message)!
    }
}
