//
//  Network.swift
//  iMap
//
//  Created by dmu mac 29 on 02/10/2025.
//

import Foundation

struct Network{
  static func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { fatalError("Bad Response") }
        if httpResponse.statusCode != 200 {
            fatalError("Bad Status Code: \(httpResponse.statusCode)")
        }
        return data
    }
}
