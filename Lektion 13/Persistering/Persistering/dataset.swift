//
//  BundleReader.swift
//  Persistering
//
//  Created by dmu mac 29 on 23/10/2025.
//

import Foundation

struct dataset{
    
    static var users: [User] = {
        let url = Bundle.main.url(forResource: "JsonData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode([User].self, from: data)
    }()
}
