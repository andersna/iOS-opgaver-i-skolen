//
//  NetworkController.swift
//  iGameOfThrones
//
//  Created by dmu mac 29 on 18/09/2025.
//

import Foundation

class NetworkService{
    static func getData(from url: URL) async throws -> Data {
        let session = URLSession.shared
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else { throw URLError(.badServerResponse) }
        return data
    }
}
